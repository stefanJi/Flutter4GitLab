import 'dart:convert';

import 'package:F4Lab/gitlab_client.dart';
import 'package:F4Lab/page/PageMrDetail.dart';
import 'package:F4Lab/util/widget_util.dart';
import 'package:F4Lab/widget/comm_ListView.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MrTab extends CommListWidget {
  final int projectId;

  MrTab(this.projectId);

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
    bool assigned = mr['assignee'] != null;
    bool hadDescription =
        mr['description'] != null && (!mr['description'].isEmpty);
    String branch = "${mr['source_branch']} → ${mr['target_branch']}";
    String uName;
    String avatarUrl;
    if (assigned) {
      uName = mr['assignee']['username'];
      avatarUrl = mr['assignee']['avatar_url'];
    }
    var card = Card(
      child: InkWell(
        onTap: () => _toMrDetatil(mr),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ListTile(
              title: Text(mr['title']),
              subtitle: assigned
                  ? Text.rich(TextSpan(children: <TextSpan>[
                      TextSpan(
                        text: uName.toUpperCase(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      TextSpan(text: " $branch")
                    ]))
                  : Text(branch),
              leading: mr['merge_status'] == 'can_be_merged'
                  ? Icon(
                      Icons.done_outline,
                      color: Colors.green,
                    )
                  : Icon(
                      Icons.error,
                      color: Colors.red,
                    ),
              trailing: assigned
                  ? Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: loadAvatar(
                        avatarUrl,
                        uName,
                      ),
                    )
                  : IgnorePointer(),
            ),
            hadDescription
                ? Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      mr['description'],
                    ),
                  )
                : IgnorePointer(),
            _MrApprove(mr['project_id'], mr['iid'])
          ],
        ),
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

/* Approve Item Json Data
{
  "id": 5,
  "iid": 5,
  "project_id": 1,
  "title": "Approvals API",
  "description": "Test",
  "state": "opened",
  "created_at": "2016-06-08T00:19:52.638Z",
  "updated_at": "2016-06-08T21:20:42.470Z",
  "merge_status": "cannot_be_merged",
  "approvals_required": 2,
  "approvals_missing": 2,
  "approved_by": [],
  "approvers": [
    {
      "user": {
        "name": "Administrator",
        "username": "root",
        "id": 1,
        "state": "active",
        "avatar_url": "http://www.gravatar.com/avatar/e64c7d89f26bd1972efa854d13d7dd61?s=80\u0026d=identicon",
        "web_url": "http://localhost:3000/u/root" 
      }
    }
  ],
  "approver_groups": [
    {
      "group": {
        "id": 5,
        "name": "group1",
        "path": "group1",
        "description": "",
        "visibility": "public",
        "lfs_enabled": false,
        "avatar_url": null,
        "web_url": "http://localhost/groups/group1",
        "request_access_enabled": false,
        "full_name": "group1",
        "full_path": "group1",
        "parent_id": null,
        "ldap_cn": null,
        "ldap_access": null
      }
    }
  ]
}
*/
class _MrApproveState extends State<_MrApprove>
    with AutomaticKeepAliveClientMixin {
  dynamic approve;

  _loadApprove() async {
    if (mounted) {
      setState(() {
        approve = null;
      });
    }
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
    bool hadApproved =
        approve['approved_by'] != null && approve['approved_by'].isNotEmpty;
    int requireApproves = approve['approvals_required'];
    int needApproves = approve['approvals_left'];

    Widget approves;
    if (hadApproved) {
      approves = Row(
        children: approve['approved_by'].map<Widget>((item) {
              return Padding(
                padding: EdgeInsets.all(2),
                child: CircleAvatar(
                  radius: 10,
                  backgroundImage: NetworkImage(item['user']['avatar_url']),
                ),
              );
            }).toList() +
            [const Text("approved.")],
      );
    }

    Widget approveTip = Text.rich(
      TextSpan(
        text: "Approvals required ",
        children: [
          TextSpan(
            text: "$requireApproves",
            style: TextStyle(
              color: Theme.of(context).accentColor,
            ),
          ),
          TextSpan(
            text: ", also need ",
          ),
          TextSpan(
            text: "$needApproves",
            style: TextStyle(
              color: Theme.of(context).accentColor,
            ),
          ),
          TextSpan(
            text: " approves.",
          ),
        ],
      ),
    );
    Widget approveBtn =
        requireApproves != null && requireApproves is int && requireApproves > 0
            ? (needApproves != null && needApproves is int && needApproves > 0
                ? RaisedButton(
                    child: const Text("Approve"),
                    onPressed: () => _approveMr(approve),
                  )
                : RaisedButton(
                    color: Colors.grey,
                    onPressed: () => _approveMr(approve, isUnApprove: true),
                    child: const Text("UnApprove"),
                  ))
            : IgnorePointer();

    Widget group = Chip(
      label: Text(
        "${(approve['approver_groups']).map((item) {
          return item['group']['name'];
        }).join(",")}",
      ),
    );

    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: hadApproved
            ? <Widget>[
                group,
                approves,
                approveTip,
                approveBtn,
              ]
            : <Widget>[
                group,
                approveTip,
                approveBtn,
              ],
      ),
    );
  }

  _approveMr(approveItem, {bool isUnApprove = false}) async {
    print(approveItem);
    final endPoint = "projects/${approveItem['project_id']}/merge_requests/"
        "${approveItem['iid']}/"
        "${isUnApprove ? "unapprove" : "approve"}";
    print(endPoint);
    final client = GitlabClient.newInstance();
    await client.post(endPoint).then((resp) {
      if (resp.statusCode == 200) {
        _loadApprove();
      } else {
        print("Approve mr error: ${resp.body}");
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("Action failed. ${resp.body}"),
          backgroundColor: Colors.red,
        ));
      }
    }).whenComplete(client.close);
  }

  @override
  bool get wantKeepAlive => true;
}
