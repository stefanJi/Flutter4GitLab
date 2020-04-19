import 'package:F4Lab/model/merge_request.dart';
import 'package:F4Lab/ui/project/mr/approve.dart';
import 'package:F4Lab/ui/project/mr/mr_home.dart';
import 'package:F4Lab/util/widget_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MrListItem extends StatelessWidget {
  final MergeRequest mr;

  const MrListItem({Key key, this.mr}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool assigned = mr.assignee != null;
    bool hadDescription = mr.description != null && (mr.description.isNotEmpty);
    String branch = "${mr.sourceBranch} → ${mr.targetBranch}";
    String uName = "";
    String avatarUrl;
    if (assigned) {
      uName = mr.assignee.username;
      avatarUrl = mr.assignee.avatarUrl;
    }
    var card = Card(
      elevation: 1.0,
      margin: EdgeInsets.only(bottom: 5.0, left: 4.0, right: 4.0, top: 5.0),
      child: InkWell(
        onTap: () => _toMrDetail(context, mr),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ListTile(
              title: RichText(
                text: TextSpan(
                    text: uName + " ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    children: [
                      TextSpan(
                          text: mr.title,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                              fontStyle: FontStyle.italic))
                    ]),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[Chip(label: Text(branch)), Text(mr.webUrl)],
              ),
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
                  ? loadAvatar(
                      avatarUrl,
                      uName,
                    )
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

  _toMrDetail(BuildContext context, MergeRequest mr) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PageMrDetail(mr.projectId, mr.iid)));
  }
}
