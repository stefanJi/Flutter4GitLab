import 'package:F4Lab/gitlab_client.dart';
import 'package:F4Lab/model/jobs.dart';
import 'package:F4Lab/widget/comm_ListView.dart';
import 'package:flutter/material.dart';

class PipelineTab extends CommListWidget {
  final int projectId;

  PipelineTab(this.projectId);

  @override
  State<StatefulWidget> createState() => _PipelineTabState(projectId);
}

class _PipelineTabState extends CommListState {
  final int projectId;

  _PipelineTabState(this.projectId) : super("projects/$projectId/jobs");

  final colors = {
    'created': Colors.teal,
    'pending': Colors.grey,
    'running': Colors.teal,
    'failed': Colors.red,
    'success': Colors.green,
    'canceled': Colors.grey,
    'skipped': Colors.grey,
    'manual': Colors.blue
  };

  @override
  Widget childBuild(BuildContext context, int index) {
    final item = Jobs.fromJson(data[index]);
    print(item);
    return Card(
      child: Padding(
          padding: EdgeInsets.all(5),
          child: Column(children: <Widget>[
            ListTile(
                leading: CircleAvatar(
                  radius: 15,
                  backgroundImage: NetworkImage(
                      "${GitlabClient.globalHOST}/uploads/-/system/user/avatar/${item.user.id}/avatar.png"),
                ),
                title: Text(item.commit.message),
                subtitle: Text("${item.user.name} :${item.createdAt}")),
            Table(
              children: <TableRow>[
                TableRow(children: <TableCell>[
                  TableCell(
                      child: Text(
                    item.status,
                    style: TextStyle(color: colors[item.status]),
                  )),
                  TableCell(child: Text(item.stage)),
                  TableCell(child: Text(item.name))
                ]),
              ],
            ),
            ButtonTheme.bar(
              child: ButtonBar(
                children: <Widget>[_buildAction(item)],
              ),
            )
          ])),
    );
  }

  Widget _buildAction(Jobs item) {
    switch (item.status) {
      case 'skipped':
      case 'pending':
        return IgnorePointer();
      case 'running':
        return OutlineButton(
            child: const Text("cancel"),
            onPressed: () => _doAction(projectId, item.id, 'cancel'));
      case 'failed':
      case 'success':
        return OutlineButton(
            child: const Text("retry"),
            onPressed: () => _doAction(projectId, item.id, 'retry'));
      case 'created':
      case 'canceled':
      case 'manual':
        return OutlineButton(
            child: const Text("play"),
            onPressed: () => _doAction(projectId, item.id, 'play'));
    }
    return IgnorePointer();
  }

  _doAction(projectId, jobId, action) async {
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text("Doing $action"),
            children: <Widget>[LinearProgressIndicator()],
          );
        });
    var url = "projects/$projectId/jobs/$jobId/$action";
    print("request url: $url");
    final client = GitlabClient.newInstance();
    final status = await client.get(url).then((resp) {
      return resp.statusCode;
    }).whenComplete(client.close);
    var snackBar;
    if (status == 200) {
      snackBar = SnackBar(content: Text('$action success!'));
      Navigator.pop(context);
    } else {
      snackBar = SnackBar(
        content: Text('$action failed! $status'),
        backgroundColor: Colors.red,
      );
      Navigator.pop(context);
    }
    Scaffold.of(context).showSnackBar(snackBar);
  }
}
