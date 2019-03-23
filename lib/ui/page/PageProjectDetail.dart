import 'package:F4Lab/page/tabs/MrTab.dart';
import 'package:flutter/material.dart';

class PageProjectDetail extends StatefulWidget {
  final String projectName;
  final int projectId;

  PageProjectDetail(this.projectName, this.projectId);

  @override
  State<StatefulWidget> createState() => PageProjectState();
}

class PageProjectState extends State<PageProjectDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("${widget.projectName} - Merge requests"),
      ),
      body: MrTab(widget.projectId),
    );
  }
}
