import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gitlab/gitlab_client.dart';
import 'package:xml/xml.dart';
import 'package:flutter_gitlab/widget/comm_ListView.dart';

class Activity extends CommListWidget {
  Activity() : super(canPullUp: false);
  @override
  State<StatefulWidget> createState() => FeedState();
}

class FeedState extends CommListState {
  FeedState() : super("");

  @override
  loadData({nextPage: 1}) async {
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
    return data;
  }

  @override
  Widget childBuild(BuildContext context, int index) {
    final item = data[index];
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
