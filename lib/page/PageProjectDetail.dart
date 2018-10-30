import 'package:flutter/material.dart';
import 'package:flutter_gitlab/widget/comm_ListView.dart';

class PageProjectDetail extends StatefulWidget {
  final String projectName;
  final int projectId;

  PageProjectDetail(this.projectName, this.projectId);

  @override
  State<StatefulWidget> createState() => PageProjectState();
}

class PageProjectState extends State<PageProjectDetail> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text(widget.projectName),
            bottom:
                TabBar(tabs: [Tab(text: 'Merge Request'), Tab(text: 'CI/CD')]),
          ),
          body: TabBarView(children: [
            _MrTab(widget.projectId),
          ]),
        ));
  }
}

class _MrTab extends CommListWidget {
  final int projectId;

  _MrTab(this.projectId);

  @override
  State<StatefulWidget> createState() => _MrState(projectId);
}

class _MrState extends CommListState {
  final int projectId;

  _MrState(this.projectId)
      : super("projects/$projectId/merge_requests?state=opened");

  @override
  Widget childBuild(BuildContext context, int index) {
    final mr = data[index];

    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text.rich(TextSpan(
                text: "${mr['author']['username']} ",
                style: TextStyle(fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                      text: mr['title'],
                      style: TextStyle(fontWeight: FontWeight.normal))
                ])),
            subtitle: Text("${mr['description'] ?? ''}"),
          ),
          ListTile(
              title: Text("${mr['source_branch']} -> ${mr['target_branch']}"),
              subtitle: Text(mr['merge_status']),
              trailing: Column(
                children: <Widget>[
                  Column(
                    children: mr['labels']
                        .map<Widget>((item) => Text.rich(TextSpan(
                            text: item,
                            style: TextStyle(color: Theme.of(context).primaryColor))))
                        .toList(),
                  )
                ],
              )),
        ],
      ),
    );
  }
}
