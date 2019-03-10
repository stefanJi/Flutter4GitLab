import 'package:F4Lab/api.dart';
import 'package:F4Lab/model/merge_request.dart';
import 'package:F4Lab/page/logic_widget/approve.dart';
import 'package:F4Lab/page/logic_widget/merge_request_action.dart';
import 'package:F4Lab/page/tabs/commit_tab.dart';
import 'package:flutter/material.dart';

class PageMrDetail extends StatefulWidget {
  final String _mrTitle;
  final int _projectId;
  final int _mergeRequestIId;

  PageMrDetail(this._mrTitle, this._projectId, this._mergeRequestIId);

  @override
  State<StatefulWidget> createState() => PageMrState();
}

class PageMrState extends State<PageMrDetail> {
  MergeRequest _mergeRequest;

  void _onMergeRequestChange(void v) {
    _loadMergeRequest();
  }

  void _loadMergeRequest() async {
    setState(() => _mergeRequest = null);
    final resp = await ApiService.getSingleMR(
        widget._projectId, widget._mergeRequestIId);
    if (resp.success) {
      setState(() => _mergeRequest = resp?.data);
    }
  }

  @override
  void initState() {
    super.initState();
    _loadMergeRequest();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: false,
            title: Text(widget._mrTitle),
            bottom: TabBar(tabs: [
              Tab(text: "info"),
              Tab(text: "commit"),
            ]),
          ),
          body: _mergeRequest == null
              ? Center(child: CircularProgressIndicator())
              : TabBarView(children: [
                  _buildInfo(),
                  CommitTab(_mergeRequest.projectId, _mergeRequest.iid),
                ]),
        ));
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

  Widget _buildInfo() {
    final title = Text(
      _mergeRequest.title,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26.0),
    );

    final desc = _mergeRequest.description != null
        ? Text(_mergeRequest.description)
        : IgnorePointer();

    final mrPlan = Card(
      child: ListTile(
        title: Text(
            "Merge: ${_mergeRequest.sourceBranch} -> ${_mergeRequest.targetBranch}"),
        trailing: _getStatusColor(_mergeRequest.mergeStatus),
      ),
    );

    final approvalAction =
        _buildApproval(_mergeRequest.projectId, _mergeRequest.iid);

    final mrAction = MergeRequestAction(_mergeRequest, _onMergeRequestChange);

    return SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            title,
            desc,
            mrPlan,
            approvalAction,
            mrAction,
          ],
        ));
  }

  Widget _buildApproval(int projectId, int mrIid) {
    return MrApprove(projectId, mrIid, showActions: true);
  }
}
