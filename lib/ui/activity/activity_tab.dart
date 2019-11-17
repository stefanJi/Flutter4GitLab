import 'dart:convert';

import 'package:F4Lab/gitlab_client.dart';
import 'package:F4Lab/util/widget_util.dart';
import 'package:F4Lab/widget/comm_ListView.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:xml/xml.dart';

class TabActivity extends CommListWidget {
  TabActivity() : super(canPullUp: false);

  @override
  State<StatefulWidget> createState() => FeedState();
}

class FeedState extends CommListState<TabActivity> {
  @override
  loadData({nextPage: 1}) async {
    final url = "dashboard/projects.atom";
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
    return data;
  }

  @override
  Widget childBuild(BuildContext context, int index) {
    final item = data[index];
    return Card(
      child: ListTile(
        leading: loadAvatar(item['avatar'], item['title']),
        title: Text(item['title']),
        onTap: () {},
      ),
    );
  }

  @override
  String endPoint() => null;
}
