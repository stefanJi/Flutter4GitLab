import 'package:F4Lab/api.dart' show ApiEndPoint;
import 'package:F4Lab/model/commit.dart';
import 'package:F4Lab/widget/comm_ListView.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CommitTab extends CommListWidget {
  final int projectId;
  final int mrIId;

  CommitTab(this.projectId, this.mrIId);

  @override
  State<StatefulWidget> createState() => _CommitState(projectId, mrIId);
}

class _CommitState extends CommListState {
  _CommitState(int projectId, int mrIId)
      : super(ApiEndPoint.mergeRequestCommit(projectId, mrIId));

  @override
  Widget childBuild(BuildContext context, int index) {
    final Commit commit = Commit.fromJson(data[index]);
    return ListTile(
      title: Text(commit.title),
    );
  }
}
