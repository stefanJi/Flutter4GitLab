import 'dart:convert';

import 'package:F4Lab/gitlab_client.dart';
import 'package:F4Lab/page/PageMrDetail.dart';
import 'package:F4Lab/widget/comm_ListView.dart';
import 'package:flutter/material.dart';

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
            centerTitle: false,
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
    return _buildItem(mr);
  }

  Widget _buildItem(mr) {
    bool assigneed = mr['assignee'] != null;
    bool hadDescription =
        mr['description'] != null && (!mr['description'].isEmpty);
    String branch = "${mr['source_branch']} → ${mr['target_branch']}";
    var card = Card(
      child: Column(
        children: <Widget>[
          ListTile(
            onTap: () => _toMrDetatil(mr),
            title: Text(mr['title']),
            subtitle: assigneed
                ? Text.rich(TextSpan(children: <TextSpan>[
                    TextSpan(
                        text: mr['assignee']['username'],
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    TextSpan(text: " $branch")
                  ]))
                : Text(branch),
            leading: mr['merge_status'] == 'can_be_merged'
                ? Icon(Icons.done_outline, color: Colors.green)
                : Icon(
                    Icons.error,
                    color: Colors.red,
                  ),
            trailing: assigneed
                ? Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: CircleAvatar(
                      radius: 15,
                      backgroundImage: NetworkImage(
                          "${GitlabClient.globalHOST}/uploads/-/system/user/avatar/${mr['assignee']['id']}/avatar.png"),
                    ))
                : IgnorePointer(),
          ),
          hadDescription
              ? ListTile(
                  onTap: () => _toMrDetatil(mr),
                  title: Text(mr['description']),
                )
              : IgnorePointer(),
          _MrApprove(mr['project_id'], mr['iid'])
        ],
      ),
    );
    return card;
  }

  _toMrDetatil(mr) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            PageMrDetail(mr['title'], mr['project_id'], mr['iid'])));
  }
}

class _MrApprove extends StatefulWidget {
  final int projectId;
  final int mrIID;

  _MrApprove(this.projectId, this.mrIID);

  @override
  State<StatefulWidget> createState() => _MrApproveState();
}

class _MrApproveState extends State<_MrApprove> {
  dynamic approve;

  _loadApprove() async {
    final client = GitlabClient.newInstance();
    final data = await client
        .get(
            'projects/${widget.projectId}/merge_requests/${widget.mrIID}/approvals')
        .then((resp) => jsonDecode(utf8.decode(resp.bodyBytes)))
        .whenComplete(client.close);
    if (mounted) {
      setState(() {
        approve = data;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadApprove();
  }

  @override
  Widget build(BuildContext context) {
    if (approve == null) {
      return LinearProgressIndicator();
    }
    return _buildItem(approve);
  }

  Widget _buildItem(approve) {
    bool approvedBy = approve['approved_by'] != null && approve['approved_by'].isNotEmpty;
    var item = Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          approvedBy
              ? Row(
                  children: <Widget>[
                        const Text('Approved by '),
                      ] +
                      approve['approved_by'].map<Widget>((item) {
                        return Padding(
                            padding: EdgeInsets.all(2),
                            child: CircleAvatar(
                              radius: 10,
                              backgroundImage:
                                  NetworkImage(item['user']['avatar_url']),
                            ));
                      }).toList() +
                      [const Text(".")])
              : IgnorePointer(),
          Row(
            children: [
              Text(
                  "Approvals required ${approve['approvals_required']}, also need ${approve['approvals_left']} approval.")
            ],
          )
        ],
      ),
    );
    return item;
  }
}
