import 'package:F4Lab/model/merge_request.dart';
import 'package:F4Lab/page/tabs/MrTab.dart';
import 'package:flutter/material.dart';

class PageMrDetail extends StatefulWidget {
  final MergeRequest _mergeRequest;

  PageMrDetail(this._mergeRequest);

  @override
  State<StatefulWidget> createState() => PageMrState();
}

class PageMrState extends State<PageMrDetail> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final title = Text(
      widget._mergeRequest.title,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26.0),
    );
    final desc = widget._mergeRequest.description != null
        ? Text(widget._mergeRequest.description)
        : IgnorePointer();
    final mrPlan = Card(
      margin: EdgeInsets.only(top: 10.0),
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: ListTile(
          title: Text(
              "Merge: ${widget._mergeRequest.sourceBranch} -> ${widget._mergeRequest.targetBranch}"),
          trailing: _getStatusColor(widget._mergeRequest.mergeStatus),
        ),
      ),
    );
    final approvalAction = _buildApproval(
        widget._mergeRequest.projectId, widget._mergeRequest.iid);

    return Scaffold(
      appBar:
          AppBar(centerTitle: false, title: Text(widget._mergeRequest.title)),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            title,
            desc,
            mrPlan,
            approvalAction,
          ],
        ),
      ),
    );
  }

  Icon _getStatusColor(String status) {
    switch (status) {
      case "can_be_merged":
        return Icon(Icons.check, color: Colors.green);
      case "cannot_be_merged":
        return Icon(Icons.highlight_off, color: Colors.red);
      default:
        return Icon(Icons.check, color: Colors.green);
    }
  }

  Widget _buildApproval(int projectId, int mrIid) {
    return MrApprove(projectId, mrIid, showActions: true);
  }
}
