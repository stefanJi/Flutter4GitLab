import 'package:F4Lab/api.dart';
import 'package:F4Lab/model/merge_request.dart';
import 'package:F4Lab/ui/project/mr/mr_list_item.dart';
import 'package:F4Lab/widget/comm_ListView.dart';
import 'package:flutter/material.dart';

class MRTab extends StatefulWidget {
  final int projectId;

  const MRTab(this.projectId);

  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<MRTab> {
  String curState;
  String curScope;

  @override
  void initState() {
    super.initState();
    curState = ApiEndPoint.merge_request_states[0];
    curScope = ApiEndPoint.merge_request_scopes[0];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildFilter(),
          Expanded(
              child: MrTab(widget.projectId,
                  mrState: curState,
                  scope: curScope,
                  key: ValueKey("$curState-$curScope"))),
        ]);
  }

  Widget _buildFilter() {
    final stateSelector = DropdownButton(
        value: curState,
        items: ApiEndPoint.merge_request_states
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (value) {
          if (value != curState) {
            setState(() {
              curState = value;
            });
          }
        });
    final scopeSelector = DropdownButton(
        value: curScope,
        items: ApiEndPoint.merge_request_scopes
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (value) {
          if (value != curScope) {
            setState(() {
              curScope = value;
            });
          }
        });

    return Padding(
        padding: EdgeInsets.all(4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text(
              "Filter: ",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            stateSelector,
            const SizedBox(
              width: 10,
            ),
            scopeSelector,
          ],
        ));
  }
}

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
