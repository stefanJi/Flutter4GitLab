import 'package:F4Lab/gitlab_client.dart';
import 'package:dio/dio.dart';
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

  RefreshController _refreshController = RefreshController();

  GitlabClient _client;

  CommListState();

  /// eg: merge_request?status=open
  String endPoint();

  loadData({nextPage: 1}) async {
    _client = GitlabClient.newInstance();
    Dio dio = GitlabClient.buildDio();

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

    final remoteData = await dio
        .get<dynamic>(url)
        .then((resp) {
          page = int.tryParse(resp.headers['x-page'][0] ?? 0);
          total = int.tryParse(resp.headers['x-total-pages'][0] ?? 0);
          next = int.tryParse(resp.headers['x-next-page'][0] ?? 0);
          return resp;
        })
        .then((resp) => resp.data)
        .catchError((err) {
          print("Error: $err");
          return [];
        });

    /*
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
*/
    return Future(() {
      final List<dynamic> _remote = List();
      remoteData.forEach((item) {
        if (!itemShouldRemove(item)) {
          _remote.add(item);
        }
      });
      return _remote;
    });
  }

  _loadMore() async {
    if (page == total) {
      _refreshController.loadNoData();
    } else {
      final remoteData = await loadData(nextPage: next);
      if (mounted) {
        setState(() {
          data.addAll(remoteData);
        });
        if (page == total) {
          _refreshController.loadNoData();
        } else {
          _refreshController.loadComplete();
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
      _refreshController.refreshCompleted();
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
    _refreshController.dispose();
    super.dispose();
  }

  Widget childBuild(BuildContext context, int index);

  bool itemShouldRemove(dynamic item) => false;

  Widget buildEmptyView() {
    return GestureDetector(
      child: Center(
          child: Text.rich(
              TextSpan(text: "🎉 No More 🎉", style: TextStyle(fontSize: 24)))),
      onTap: () {
        _refreshController.requestRefresh();
        _loadNew();
      },
    );
  }

  Widget buildDataListView() {
    return SmartRefresher(
        controller: _refreshController,
        enablePullDown: widget.canPullDown,
        enablePullUp: widget.canPullUp,
        onRefresh: () => _loadNew(),
        onLoading: () => _loadMore(),
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
