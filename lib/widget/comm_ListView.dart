import 'dart:convert';

import 'package:F4Lab/gitlab_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

abstract class CommListWidget extends StatefulWidget {
  final bool canPullUp;
  final bool canPullDown;
  final bool withPage;

  CommListWidget(
      {this.canPullDown = true, this.canPullUp = true, this.withPage = true});
}

abstract class CommListState extends State<CommListWidget>
    with AutomaticKeepAliveClientMixin<CommListWidget> {
  @override
  bool get wantKeepAlive => true;
  final String _endPoint;
  RefreshController _refreshController = RefreshController();
  List data;
  int page;
  int total;
  int next;
  bool _hasLoadOnce = false;

  /// _endPoint like: merge_request?status=open
  CommListState(this._endPoint);

  loadData({nextPage: 1}) async {
    final client = GitlabClient.newInstance();
    var url;
    if (widget.withPage) {
      url = "$_endPoint&page=$nextPage&per_page=10";
    } else {
      url = _endPoint;
    }
    print("request url: ${client.getRequestUrl(url)}");
    final remoteData = await client
        .get(url)
        .then((resp) {
          page = int.tryParse(resp.headers['x-page'] ?? 0);
          total = int.tryParse(resp.headers['x-total-pages'] ?? 0);
          next = int.tryParse(resp.headers['x-next-page'] ?? 0);
          return resp;
        })
        .then((resp) => utf8.decode(resp.bodyBytes))
        .then((s) => jsonDecode(s))
        .catchError((err) {
          print("loadData err: $err");
          return [];
        })
        .whenComplete(client.close);
    return remoteData;
  }

  _loadMore() async {
    if (page == total) {
      _refreshController.sendBack(false, RefreshStatus.noMore);
    } else {
      final remoteData = await loadData(nextPage: next);
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
    final remoteDate = await loadData();
    if (mounted) {
      setState(() {
        data = remoteDate;
      });
      if (_hasLoadOnce) {
        _refreshController.sendBack(true, RefreshStatus.completed);
        if (page == total) {
          _refreshController.sendBack(false, RefreshStatus.noMore);
        } else {
          _refreshController.sendBack(false, RefreshStatus.canRefresh);
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _loadNew();
  }

  Widget childBuild(BuildContext context, int index);

  Widget buildEmptyView() {
    return Center(
      child: Text.rich(
          TextSpan(text: "🎉 No More 🎉", style: TextStyle(fontSize: 24))),
    );
  }

  Widget buildDataListView() {
    return SmartRefresher(
        controller: _refreshController,
        enablePullDown: widget.canPullDown,
        enablePullUp: widget.canPullUp,
        onRefresh: (up) {
          if (up) {
            if (!_hasLoadOnce) {
              _hasLoadOnce = true;
            }
            _loadNew();
          } else {
            _loadMore();
          }
        },
        child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return childBuild(context, index);
            }));
  }

  @override
  Widget build(BuildContext context) {
    return data == null
        ? Center(child: CircularProgressIndicator())
        : data.length == 0 ? buildEmptyView() : buildDataListView();
  }
}
