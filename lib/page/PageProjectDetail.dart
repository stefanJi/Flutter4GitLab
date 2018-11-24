import 'package:F4Lab/page/tabs/MrTab.dart';
import 'package:F4Lab/page/tabs/PipelineTab.dart';
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
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: false,
            title: Text(widget.projectName),
            bottom:
                TabBar(tabs: [Tab(text: 'Merge Request'), Tab(text: 'Jobs')]),
          ),
          body: TabBarView(children: [
            MrTab(widget.projectId),
            PipelineTab(widget.projectId)
          ]),
        ));
  }
}
