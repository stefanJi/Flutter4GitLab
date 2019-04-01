import 'dart:convert';

import 'package:F4Lab/gitlab_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

///[canPullUp] This bool will affect whether or not to have the function of drop-up load
///[canPullDown] This bool will affect whether or not to have the function of drop-down refresh
///[withPage] Tihs bool will affect whether or not to add page arg to request url
abstract class CommListWidget extends StatefulWidget {
  final bool canPullUp;

  final bool canPullDown;

  final bool withPage;

  CommListWidget(
      {this.canPullDown = true, this.canPullUp = true, this.withPage = true});
}

abstract class CommListState<T extends CommListWidget> extends State<T>
    with SingleTickerProviderStateMixin {
  List<dynamic> data;
  int page;
  int total;
  int next;

  bool _hasLoadOnce = false;
  RefreshController _refreshController = RefreshController();

  GitlabClient _client;

  CommListState();

  /// eg: merge_request?status=open
  String endPoint();

  loadData({nextPage: 1}) async {
    _client = GitlabClient.newInstance();
    var url;
    final _endPoint = endPoint() ?? "";
    if (widget.withPage) {
      if (!_endPoint.contains("?")) {
        url = "$_endPoint?page=$nextPage&per_page=10";
      } else {
        url = "$_endPoint&page=$nextPage&per_page=10";
      }
    } else {
      url = _endPoint;
    }
    final remoteData = await _client
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
        .whenComplete(_client.close);
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
    final remoteDate = await loadData() as List;
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

  @override
  void dispose() {
    if (_client != null) {
      _client.close();
    }
    super.dispose();
  }

  Widget childBuild(BuildContext context, int index);

  Widget buildEmptyView() {
    return GestureDetector(
      child: Center(
          child: Text.rich(
              TextSpan(text: "🎉 No More 🎉", style: TextStyle(fontSize: 24)))),
      onTap: () {
        _loadNew();
      },
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
