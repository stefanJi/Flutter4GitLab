import 'dart:convert';

import 'package:F4Lab/gitlab_client.dart';
import 'package:F4Lab/model/approvals.dart';
import 'package:F4Lab/model/merge_request.dart';
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
    return _buildItem(data[index]);
  }

  Widget _buildItem(item) {
    final mr = MergeRequest.fromJson(item);
    bool assigned = mr.assignee != null;
    bool hadDescription = mr.description != null && (!mr.description.isEmpty);
    String branch = "${mr.sourceBranch} → ${mr.targetBranch}";
    String uName;
    String avatarUrl;
    if (assigned) {
      uName = mr.assignee.username;
      avatarUrl = mr.assignee.avatarUrl;
    }
    var card = Card(
      elevation: 1.0,
      margin: EdgeInsets.only(bottom: 5.0, left: 4.0, right: 4.0, top: 5.0),
      child: InkWell(
        onTap: () => _toMrDetail(mr),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ListTile(
              title: Text(mr.title),
              subtitle: Text(branch),
              leading: mr.mergeStatus == 'can_be_merged'
                  ? Icon(
                      Icons.done,
                      color: Colors.green,
                    )
                  : Icon(
                      Icons.highlight_off,
                      color: Colors.red,
                    ),
              trailing: assigned
                  ? Column(children: <Widget>[
                      loadAvatar(
                        avatarUrl,
                        uName,
                      ),
                      Text(uName ?? "")
                    ])
                  : IgnorePointer(),
            ),
            hadDescription
                ? Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      mr.description,
                    ),
                  )
                : IgnorePointer(),
            MrApprove(mr.projectId, mr.iid)
          ],
        ),
      ),
    );
    return card;
  }

  _toMrDetail(MergeRequest mr) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PageMrDetail(mr.title, mr.projectId, mr.iid)));
  }
}

class MrApprove extends StatefulWidget {
  final int projectId;
  final int mrIID;

  MrApprove(this.projectId, this.mrIID);

  @override
  State<StatefulWidget> createState() => _MrApproveState();
}

class _MrApproveState extends State<MrApprove>
    with AutomaticKeepAliveClientMixin {
  Approvals approval;

  void _loadApprove() async {
    final client = GitlabClient.newInstance();
    final data = await client
        .get(
            'projects/${widget.projectId}/merge_requests/${widget.mrIID}/approvals')
        .then((resp) => jsonDecode(utf8.decode(resp.bodyBytes)))
        .whenComplete(client.close);
    if (mounted) {
      setState(() {
        approval = Approvals.fromJson(data);
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
    if (approval == null) {
      return LinearProgressIndicator();
    }
    return _buildItem(approval);
  }

  Widget _buildItem(Approvals approval) {
    int requireApproves = approval.approvalsRequired ?? 0;
    int hadApproval =
        approval.approvedBy != null ? approval.approvedBy.length : 0;

    return Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          children: <Widget>[
            Icon(Icons.sentiment_neutral),
            Padding(
              padding: EdgeInsets.all(5),
              child: Text(
                "$hadApproval of $requireApproves",
                style: TextStyle(
                    color: requireApproves == hadApproval
                        ? Colors.green
                        : Colors.grey),
              ),
            )
          ],
        ));
  }

  @override
  bool get wantKeepAlive => true;
}
