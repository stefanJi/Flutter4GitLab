import 'package:F4Lab/api.dart';
import 'package:F4Lab/ui/tabs/MrTab.dart';
import 'package:flutter/material.dart';

class PageProjectDetail extends StatefulWidget {
  final String projectName;
  final int projectId;

  PageProjectDetail(this.projectName, this.projectId);

  @override
  State<StatefulWidget> createState() => PageProjectState();
}

class PageProjectState extends State<PageProjectDetail> {
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
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("${widget.projectName} - $curState - MR"),
      ),
      body: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildFilter(),
            Expanded(
              child: MrTab(
                widget.projectId,
                mrState: curState,
                scope: curScope,
                key: ValueKey("$curState-$curScope"),
              ),
            ),
          ]),
    );
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
