import 'package:F4Lab/api.dart';
import 'package:F4Lab/model/merge_request.dart';
import 'package:F4Lab/ui/project/mr/approve.dart';
import 'package:F4Lab/ui/project/mr/merge_request_action.dart';
import 'package:F4Lab/ui/project/mr/mr_tab_jobs.dart';
import 'package:F4Lab/ui/project/mr/mr_detail_tabs.dart';
import 'package:flutter/material.dart';

class PageMrDetail extends StatefulWidget {
  final int _projectId;
  final int _mergeRequestIId;

  PageMrDetail(this._projectId, this._mergeRequestIId);

  @override
  State<StatefulWidget> createState() => PageMrState();
}

class PageMrState extends State<PageMrDetail> {
  MergeRequest _mr;

  void _onMergeRequestChange(void v) {
    _loadMergeRequest();
  }

  void _loadMergeRequest() async {
    setState(() => _mr = null);
    final resp = await ApiService.getSingleMR(
        widget._projectId, widget._mergeRequestIId);
    if (resp.success) {
      setState(() => _mr = resp?.data);
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
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: false,
            title: Text("MR #${widget._mergeRequestIId}"),
            bottom: TabBar(isScrollable: true, tabs: [
              Tab(text: "Overview"),
              Tab(text: "Commits"),
              Tab(text: "Discussions"),
              Tab(text: "Jobs"),
            ]),
          ),
          body: _mr == null
              ? Center(child: CircularProgressIndicator())
              : TabBarView(
                  children: [
                    _buildInfo(),
                    CommitTab(_mr.projectId, _mr.iid),
                    DiscussionTab(_mr.projectId, _mr.iid),
                    MergeRequestJobsTab(_mr.projectId, _mr.iid)
                  ],
                ),
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
      _mr.title,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26.0),
    );

    final desc =
        _mr.description != null ? Text(_mr.description) : IgnorePointer();

    final mrPlan = Card(
      child: ListTile(
        title: Text("Merge: ${_mr.sourceBranch} -> ${_mr.targetBranch}"),
        trailing: _getStatusColor(_mr.mergeStatus),
      ),
    );

    final approvalAction = _buildApproval(_mr.projectId, _mr.iid);

    final mrAction = MergeRequestAction(_mr, _onMergeRequestChange);

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
