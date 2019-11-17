import 'package:F4Lab/api.dart';
import 'package:F4Lab/model/merge_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MergeRequestAction extends StatefulWidget {
  final MergeRequest mr;
  final ValueChanged<void> mergeRequestChange;

  const MergeRequestAction(this.mr, this.mergeRequestChange);

  @override
  State<StatefulWidget> createState() => _MergeReqestState();
}

class _MergeReqestState extends State<MergeRequestAction> {
  bool _removeBranch = false;
  bool _mergeWhenPiplineSuccess = false;
  bool _squashCommit = false;

  bool _canMerge = false;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _mergeWhenPiplineSuccess = widget.mr.mergeWhenPipelineSucceeds;
  }

  void _rebase() async {
    _showLoading();
    final resp = await ApiService.rebaseMr(widget.mr.projectId, widget.mr.iid);
    if (resp.success) {
      widget.mergeRequestChange(null);
    }
    _hideLoading();
  }

  void _merge() async {
    _showLoading();
    final resp = await ApiService.acceptMR(widget.mr.projectId, widget.mr.iid,
        shouldRemoveSourceBranch: _removeBranch,
        squash: _squashCommit,
        mergeMrWhenPipelineSuccess: _mergeWhenPiplineSuccess);
    if (resp.success) {
      widget.mergeRequestChange(null);
    }
    _hideLoading();
  }

  Widget _buildMergeButton() {
    final mr = widget.mr;
    String title;
    Function onPress;
    if (mr.divergedCommitsCount > 0) {
      title = mr.rebaseInProgress ? "Rebaseing" : "Rebase";
      onPress = mr.rebaseInProgress ? null : _rebase;
    } else if (mr.workInProgress) {
      title = "Remove WIP(Not Suuport)";
      onPress = null;
    } else if (mr.state == "merged") {
      _canMerge = false;
      title = "Merged";
      onPress = null;
    } else {
      _canMerge = true;
      title = "Merge";
      onPress = _merge;
    }
    return RaisedButton(child: Text(title), onPressed: onPress);
  }

  Widget _buildRefreshButton() {
    return IconButton(
      icon: Icon(Icons.refresh),
      onPressed: () {
        widget.mergeRequestChange(null);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final checkBoxs = Column(
      children: <Widget>[
        CheckboxListTile(
          value: _removeBranch,
          onChanged: (bool newValue) {
            setState(() => _removeBranch = newValue);
          },
          title: Text("Remove Source Branch ?"),
        ),
        CheckboxListTile(
          value: _mergeWhenPiplineSuccess,
          onChanged: (bool newValue) {
            setState(() => _mergeWhenPiplineSuccess = newValue);
          },
          title: Text("Merge When Pipeline Success ?"),
        ),
        CheckboxListTile(
          value: _squashCommit,
          onChanged: (bool newValue) {
            setState(() => _squashCommit = newValue);
          },
          title: Text("Squashed into a single commit ?"),
        ),
      ],
    );

    final actions = Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: _buildRefreshButton(),
        ),
        Expanded(
          flex: 1,
          child: _buildMergeButton(),
        ),
      ],
    );

    final widgets = [
      _canMerge ? checkBoxs : IgnorePointer(),
      actions,
      _loading ? LinearProgressIndicator() : IgnorePointer()
    ];

    final content = ListTile(
      title: const Text("Merge request actions"),
      subtitle: Column(children: widgets),
    );

    return Card(child: content);
  }

  void _showLoading() {
    setState(() => _loading = true);
  }

  void _hideLoading() {
    setState(() => _loading = false);
  }
}
