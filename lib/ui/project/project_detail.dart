import 'package:F4Lab/ui/project/jobs/jobs_tab.dart';
import 'package:F4Lab/ui/project/mr/mr_list.dart';
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
            title: Text("${widget.projectName}"),
            centerTitle: false,
            bottom: TabBar(
              tabs: <Widget>[
                Tab(text: "MR"),
                Tab(text: "Jobs"),
              ],
            )),
        body: TabBarView(children: [
          MRTab(this.widget.projectId),
          JobsTab(this.widget.projectId)
        ]),
      ),
    );
  }
}
