import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_gitlab/gitlab_client.dart';

class PageMrDetail extends StatefulWidget {
  final String title;
  final int projectId;
  final int mergeRequestIId;

  PageMrDetail(this.title, this.projectId, this.mergeRequestIId);

  @override
  State<StatefulWidget> createState() => PageMrState();
}

class PageMrState extends State<PageMrDetail> {
  dynamic _info;

  @override
  void initState() {
    super.initState();
    _loadMrInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: false, title: Text(widget.title)),
      body: _info == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              padding: EdgeInsets.all(32.0),
              child: Column(
                children: <Widget>[
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text("Opened by ${_info['author']['username']}"),
                        Chip(
                          label: Text("${_info['merge_status']}"),
                          backgroundColor:
                              _getStatusColor(_info['merge_status']),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      widget.title,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
    );
  }

  _loadMrInfo() async {
    final client = GitlabClient.newInstance();
    final info = await client
        .get(
            "projects/${widget.projectId}/merge_requests/${widget.mergeRequestIId}")
        .then((resp) {
      return jsonDecode(utf8.decode(resp.bodyBytes));
    }).catchError((err) {
      print("[loadMrInfo ]err: ${err.toString()}");
      return null;
    }).whenComplete(client.close);
    if (mounted) {
      setState(() {
        _info = info;
      });
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "can_be_merged":
        return Colors.green;
      case "cannot_be_merged":
        return Colors.red;
      default:
        return Colors.green;
    }
  }
}
