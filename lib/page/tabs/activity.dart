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

const types = [typeMR, typeIssue,];

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
      case typeIssue:
        return IssueState();
    }
    return null;
  }
}

abstract class ActivityState extends State<ActivityTab>
    with AutomaticKeepAliveClientMixin<ActivityTab> {
  @override
  bool get wantKeepAlive => true;
  final String _endPoint;
  RefreshController _refreshController = RefreshController();
  List _data;
  dynamic _page;
  dynamic _total;
  dynamic _next;

  ActivityState(this._endPoint);

  _loadData({page: 1}) async {
    final client = GitlabClient.newInstance();
    final data = await client
        .get('$_endPoint&page=$page&per_page=10')
        .then((resp) {
          _page = resp.headers['x-page'];
          _total = resp.headers['x-total-pages'];
          _next = resp.headers['x-next-page'];
          print(resp.body);
          return resp;
        })
        .then((resp) => utf8.decode(resp.bodyBytes))
        .then((s) => jsonDecode(s))
        .catchError(print)
        .whenComplete(client.close);
    return data;
  }

  _loadMore() async {
    if (_page == _total) {
      _refreshController.sendBack(false, RefreshStatus.noMore);
    } else {
      final data = await _loadData(page: _next);
      if (mounted) {
        setState(() {
          _data.addAll(data);
        });
        if (_page == _total) {
          _refreshController.sendBack(false, RefreshStatus.noMore);
        } else {
          _refreshController.sendBack(false, RefreshStatus.canRefresh);
        }
      }
    }
  }

  _loadNew() async {
    final data = await _loadData();
    if (mounted) {
      setState(() {
        _data = data;
      });
      _refreshController.sendBack(true, RefreshStatus.completed);
      if (_page == _total) {
        _refreshController.sendBack(false, RefreshStatus.noMore);
      } else {
        _refreshController.sendBack(false, RefreshStatus.canRefresh);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _loadNew();
  }

  Widget childBuild(BuildContext context, int index);

  @override
  Widget build(BuildContext context) {
    return _data == null
        ? Center(child: CircularProgressIndicator())
        : SmartRefresher(
            controller: _refreshController,
            enablePullDown: true,
            enablePullUp: true,
            onRefresh: (up) {
              if (up) {
                _loadNew();
              } else {
                _loadMore();
              }
            },
            child: ListView.builder(
                itemCount: _data == null ? 0 : _data.length,
                itemBuilder: (context, index) {
                  return childBuild(context, index);
                }));
  }
}

class MRState extends ActivityState {
  MRState() : super("merge_requests?state=opened&scope=all");

  Widget childBuild(BuildContext context, int index) {
    final mr = _data[index];
    return Card(
        child: Column(
      children: <Widget>[
        ListTile(
            onTap: () => print(index),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://git.llsapp.com/uploads/-/system/user/avatar/${mr['author']['id']}/avatar.png"),
            ),
            title: Text.rich(TextSpan(
                style: TextStyle(fontWeight: FontWeight.bold),
                text: "${mr['author']['username']} ",
                children: [
                  TextSpan(
                      text: "「${mr['title']}」 ",
                      style: TextStyle(fontWeight: FontWeight.normal)),
                  TextSpan(
                      text: "${mr['source_branch']} 🚀 ${mr['target_branch']}",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.normal)),
                ])),
            subtitle: Row(
              children: mr['labels'] == null
                  ? <Widget>[]
                  : mr['labels'].map<Widget>((label) {
                      return Text(
                        label,
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      );
                    }).toList(),
            )),
        ButtonTheme.bar(
          child: ButtonBar(
            children: <Widget>[
              FlatButton(onPressed: () {}, child: const Text('Review')),
              FlatButton(onPressed: () {}, child: const Text('Comment')),
              FlatButton(onPressed: () {}, child: const Text('Approve')),
              FlatButton(onPressed: () {}, child: const Text('Merge')),
            ],
          ),
        )
      ],
    ));
  }
}

class IssueState extends ActivityState {
  IssueState() : super("issues?state=opened&scope=all");

  Widget childBuild(BuildContext context, int index) {
    final issue = _data[index];
    return Card(
      child: ListTile(
        title: Text("${issue['title']}"),
      ),
    );
  }
}
