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

abstract class CommListState<T extends CommListWidget> extends State<T> {
  List<dynamic> data;
  int page;
  int total;
  int next;

  RefreshController _refreshController = RefreshController();

  /// eg: merge_request?status=open
  String endPoint();

  loadData({nextPage: 1}) async {
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
    _refreshController.dispose();
    super.dispose();
  }

  Widget childBuild(BuildContext context, int index);

  bool itemShouldRemove(dynamic item) => false;

  Widget buildEmptyView() {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 100),
        child: Text.rich(
          TextSpan(
            text: "🎉 No More 🎉\n\nPull Down To Refresh",
            style: TextStyle(fontSize: 16),
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget buildDataListView() {
    return SmartRefresher(
        controller: _refreshController,
        enablePullDown: widget.canPullDown,
        enablePullUp: widget.canPullUp,
        onRefresh: () => _loadNew(),
        onLoading: () => _loadMore(),
        child: data.length == 0
            ? ListView.builder(
                itemCount: 1,
                itemBuilder: (ctx, index) {
                  return buildEmptyView();
                })
            : ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return childBuild(context, index);
                }));
  }

  @override
  Widget build(BuildContext context) {
    return data == null
        ? Center(child: CircularProgressIndicator())
        : buildDataListView();
  }
}
