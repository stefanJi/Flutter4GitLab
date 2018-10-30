import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gitlab/gitlab_client.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

abstract class CommListWidget extends StatefulWidget {}

abstract class CommListState extends State<CommListWidget>
    with AutomaticKeepAliveClientMixin<CommListWidget> {
  @override
  bool get wantKeepAlive => true;
  final String _endPoint;
  RefreshController _refreshController = RefreshController();
  List data;
  dynamic page;
  dynamic total;
  dynamic next;

  /// _endPoint like: merge_request?status=open
  CommListState(this._endPoint);

  _loadData({nextPage: 1}) async {
    final client = GitlabClient.newInstance();
    final remoteData = await client
        .get('$_endPoint&page=$nextPage&per_page=10')
        .then((resp) {
          page = resp.headers['x-page'];
          total = resp.headers['x-total-pages'];
          next = resp.headers['x-next-page'];
          return resp;
        })
        .then((resp) => utf8.decode(resp.bodyBytes))
        .then((s) => jsonDecode(s))
        .catchError(print)
        .whenComplete(client.close);
    return remoteData;
  }

  _loadMore() async {
    if (page == total) {
      _refreshController.sendBack(false, RefreshStatus.noMore);
    } else {
      final remoteData = await _loadData(nextPage: next);
      if (mounted) {
        setState(() {
          data.addAll(remoteData);
        });
        if (page == total) {
          _refreshController.sendBack(false, RefreshStatus.noMore);
        } else {
          _refreshController.sendBack(false, RefreshStatus.canRefresh);
        }
      }
    }
  }

  _loadNew() async {
    final remoteDate = await _loadData();
    if (mounted) {
      setState(() {
        data = remoteDate;
      });
      _refreshController.sendBack(true, RefreshStatus.completed);
      if (page == total) {
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
    return data == null
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
                itemCount: data == null ? 0 : data.length,
                itemBuilder: (context, index) {
                  return childBuild(context, index);
                }));
  }
}
