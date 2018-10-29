import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_gitlab/gitlab_client.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

const typeAll = 1;
const typeOwn = 2;
const typeStarted = 3;

class Project extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: TabBar(
              labelColor: Theme.of(context).primaryColor,
              indicatorColor: Theme.of(context).primaryColor,
              tabs: [
                Tab(text: "All"),
                Tab(text: "Your"),
                Tab(text: "Started"),
              ]),
          body: TabBarView(children: <Widget>[
            ListTab(typeAll),
            ListTab(typeOwn),
            ListTab(typeStarted)
          ]),
        ));
  }
}

class ListTab extends StatefulWidget {
  final int _type;

  ListTab(this._type);

  @override
  State<StatefulWidget> createState() => ListTabState();
}

class ListTabState extends State<ListTab>
    with AutomaticKeepAliveClientMixin<ListTab> {
  RefreshController _refreshController = RefreshController();
  dynamic arr;

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  _loadData({page = 1}) async {
    var point =
        "projects?order_by=updated_at&per_page=10&simple=true&page=$page";
    switch (widget._type) {
      case typeAll:
        point = '$point&membership=true';
        break;
      case typeOwn:
        point = '$point&owned=true';
        break;
      case typeStarted:
        point = '$point&starred=true';
        break;
    }
    final client = GitlabClient.newInstance();
    final resp = await client
        .get(point)
        .then((resp) {
          print("page: " + resp.headers['x-page']);
          print("next: " + resp.headers['x-next-page']);
          print("total: " + resp.headers['x-total-pages']);
          return {
            'data': jsonDecode(utf8.decode(resp.bodyBytes)),
            'next': resp.headers['x-next-page'],
            'total': resp.headers['x-total-pages'],
            'cur': resp.headers['x-page']
          };
        })
        .catchError(print)
        .whenComplete(client.close);
    return resp;
  }

  _refresh() async {
    final data = await _loadData();
    if (mounted) {
      setState(() {
        arr = data;
      });
      _refreshController.sendBack(true, RefreshStatus.completed);
      if (arr['cur'] == arr['total']) {
        _refreshController.sendBack(false, RefreshStatus.noMore);
      } else {
        _refreshController.sendBack(false, RefreshStatus.canRefresh);
      }
    }
  }

  _loadMore() async {
    final data = await _loadData(page: arr['next']);
    if (mounted) {
      setState(() {
        arr['data'].addAll(data['data']);
        arr['next'] = data['next'];
        arr['cur'] = data['cur'];
        arr['total'] = data['total'];
      });
      if (arr['cur'] == arr['total']) {
        _refreshController.sendBack(false, RefreshStatus.noMore);
      } else {
        _refreshController.sendBack(false, RefreshStatus.completed);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return arr == null
        ? Center(child: CircularProgressIndicator())
        : SmartRefresher(
            enablePullUp: true,
            enablePullDown: true,
            enableOverScroll: true,
            controller: _refreshController,
            onRefresh: (up) {
              if (up) {
                // 下拉刷新
                _refresh();
              } else {
                // 上拉加载
                _loadMore();
              }
            },
            child: ListView.builder(
              itemCount: arr != null ? arr['data'].length : 0,
              itemBuilder: (context, index) {
                final item = arr['data'][index];
                return Card(
                  child: ListTile(
                    leading: item['avatar_url'] != null
                        ? CircleAvatar(
                            backgroundImage: NetworkImage(item['avatar_url']),
                            backgroundColor: Theme.of(context).primaryColor,
                          )
                        : CircleAvatar(
                            backgroundColor: Theme.of(context).primaryColor,
                            child: Text(
                                item['name'].substring(0, 1).toUpperCase()),
                          ),
                    title: Text(item['name_with_namespace']),
                    subtitle: Text(item['description'] ?? ''),
                    onTap: () {},
                  ),
                );
              },
            ));
  }

  @override
  bool get wantKeepAlive => true;
}
