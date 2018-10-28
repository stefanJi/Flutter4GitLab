import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gitlab/gitlab_client.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

const typeMR = 'Meger Request';
const typePush = 'Push Event';
const typeIssue = 'Issues';
const typeComments = 'Comments';
const team = 'Team';

const types = [typeMR, typePush, typeIssue, typeComments];

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
                  types.map<Widget>((type) => ActivityTab(type)).toList()),
        ));
  }
}

class ActivityTab extends StatefulWidget {
  final String type;

  ActivityTab(this.type);

  @override
  State<StatefulWidget> createState() {
    switch (type) {
      case typeMR:
        return MRState();
        break;
    }
    return ActivityTabState();
  }
}

class ActivityTabState extends State<ActivityTab>
    with AutomaticKeepAliveClientMixin<ActivityTab> {
  @override
  bool get wantKeepAlive => true;
  final RefreshController _refreshController = RefreshController();

  _fetchAllEvent() async {
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
              child: ListTile(),
            );
          },
        ));
  }
}

class MRState extends State<ActivityTab>
    with AutomaticKeepAliveClientMixin<ActivityTab> {
  @override
  bool get wantKeepAlive => true;
  List mrs;
  RefreshController _refreshController = RefreshController();

  @override
  void initState() {
    super.initState();
    _loadMr();
  }

  _loadMr({page: 1}) async {
    _refreshController.sendBack(true, RefreshStatus.refreshing);
    final client = GitlabClient.newInstance();
    final data = await client
        .get('merge_requests?state=opened&scope=all&page=$page&per_page=10')
        .then((resp) => utf8.decode(resp.bodyBytes))
        .then((s) => jsonDecode(s))
        .catchError(print)
        .whenComplete(client.close);
    print(data);
    if (mounted) {
      setState(() {
        mrs = data;
      });
      _refreshController.sendBack(true, RefreshStatus.completed);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        enablePullUp: true,
        onRefresh: (up) {
          if (up) {
            _loadMr();
          }
        },
        child: ListView.builder(
            itemCount: mrs == null ? 0 : mrs.length,
            itemBuilder: (context, index) {
              final mr = mrs[index];
              return Card(
                  child: Column(
                children: <Widget>[
                  ListTile(
                      onTap: () => print(index),
                      title:
                          Text("🤠 ${mr['author']['username']} ⌨️ ${mr['title']}"),
                      subtitle: Column(
                          textDirection: TextDirection.ltr,
                          children: <Widget>[
                            mr['description'] != null
                                ? Text("${mr['description']}")
                                : Text(''),
                            Text(
                                "${mr['source_branch']} ➡️ ${mr['target_branch']}"),
                            Row(
                              children: mr['labels'] == null
                                  ? <Widget>[]
                                  : mr['labels'].map<Widget>((label) {
                                      return Text(
                                        label,
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor),
                                      );
                                    }).toList(),
                            ),
                          ])),
                ],
              ));
            }));
  }
}
