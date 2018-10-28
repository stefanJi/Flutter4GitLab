import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gitlab/gitlab_client.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

const types = [
  'All',
  'Push Event',
  'Merger Request',
  'Isuue',
  'Comments',
  'Team'
];

class Activity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: types.length,
        child: Scaffold(
          appBar: TabBar(
              isScrollable: true,
              indicatorSize: TabBarIndicatorSize.tab,
              labelColor: Theme.of(context).primaryColor,
              indicatorColor: Theme.of(context).primaryColor,
              tabs: types.map<Widget>((item) => Tab(text: item)).toList()),
          body: TabBarView(
              children:
                  types.map<Widget>((item) => ActivityTab(item)).toList()),
        ));
  }
}

class ActivityTab extends StatefulWidget {
  final String type;

  ActivityTab(this.type);

  @override
  State<StatefulWidget> createState() => ActivityTabState();
}

class ActivityTabState extends State<ActivityTab>
    with AutomaticKeepAliveClientMixin<ActivityTab> {
  @override
  bool get wantKeepAlive => true;
  final RefreshController _refreshController = RefreshController();

  _fetchProjects() async {
    final client = GitlabClient.newInstance();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        enablePullUp: true,
        child: ListView.builder(
          itemCount: 0,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(

              ),
            );
          },
        ));
  }
}
