import 'package:F4Lab/api.dart';
import 'package:F4Lab/model/merge_request.dart';
import 'package:F4Lab/ui/logic_widget/approve.dart';
import 'package:F4Lab/ui/page/PageMrDetail.dart';
import 'package:F4Lab/util/widget_util.dart';
import 'package:F4Lab/widget/comm_ListView.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MrTab extends CommListWidget {
  final int projectId;
  final String mrState;
  final String scope;
  final Key key;

  MrTab(this.projectId, {this.mrState, this.key, this.scope});

  @override
  State<StatefulWidget> createState() => _MrState();
}

class _MrState extends CommListState<MrTab> {
  @override
  Widget childBuild(BuildContext context, int index) {
    return _buildItem(data[index]);
  }

  Widget _buildItem(item) {
    final mr = MergeRequest.fromJson(item);
    bool assigned = mr.assignee != null;
    bool hadDescription = mr.description != null && (mr.description.isNotEmpty);
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

  @override
  String endPoint() => ApiEndPoint.mergeRequests(widget.projectId,
      state: widget.mrState, scope: widget.scope);
}
