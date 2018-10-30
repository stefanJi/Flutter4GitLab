import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gitlab/gitlab_client.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:xml/xml.dart';

class Activity extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FeedState();
}

class FeedState extends State<Activity> {
  List _feeds;

  _loadRss() async {
    final url = "dashboard/projects.atom?rss_token=XcV4SEjeywunDFXQRnLu";
    final client = GitlabClient.newInstance();
    final data = await client.getRss(url).then((resp) {
      final data = utf8.decode(resp.bodyBytes);
      final XmlDocument doc = parse(data);
      var entries = doc.findAllElements("entry");
      final feeds = entries.map((ele) {
        return {
          'title': ele.findElements("title").single.text,
          'updated': ele.findElements('updated').single.text,
          'link': ele.findElements('link').single.getAttribute("href"),
          'avatar':
              ele.findElements('media:thumbnail').single.getAttribute('url')
        };
      });
      return feeds.toList();
    }).whenComplete(client.close);
    if (mounted) {
      setState(() {
        _feeds = data;
      });
      _refreshController.sendBack(true, RefreshStatus.completed);
    }
  }

  @override
  void initState() {
    super.initState();
    _refreshController = RefreshController();
    _loadRss();
  }

  RefreshController _refreshController;

  @override
  Widget build(BuildContext context) {
    return _feeds == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : SmartRefresher(
            controller: _refreshController,
            enablePullDown: true,
            onRefresh: (up) {
              if (up) {
                _loadRss();
              }
            },
            child: ListView.builder(
                itemCount: _feeds.length,
                itemBuilder: (context, index) {
                  final item = _feeds[index];
                  return _buildItem(item);
                }));
  }

  Widget _buildItem(item) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(item['avatar']),
        ),
        title: Text(item['title']),
        onTap: () {},
      ),
    );
  }
}
