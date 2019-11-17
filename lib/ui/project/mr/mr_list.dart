import 'package:F4Lab/api.dart';
import 'package:F4Lab/model/merge_request.dart';
import 'package:F4Lab/ui/project/mr/mr_list_item.dart';
import 'package:F4Lab/widget/comm_ListView.dart';
import 'package:flutter/material.dart';

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
    return MrListItem(mr: mr);
  }

  @override
  String endPoint() => ApiEndPoint.mergeRequests(widget.projectId,
      state: widget.mrState, scope: widget.scope);
}
