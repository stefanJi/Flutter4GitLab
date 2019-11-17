import 'package:F4Lab/api.dart';
import 'package:F4Lab/model/commit.dart';
import 'package:F4Lab/model/diff.dart';
import 'package:F4Lab/ui/project/mr/diff.dart';
import 'package:flutter/material.dart';

class PageCommitDiff extends StatefulWidget {
  final int projectId;
  final Commit commit;

  const PageCommitDiff(this.projectId, this.commit);

  @override
  State<StatefulWidget> createState() => _DiffState();
}

class _DiffState extends State<PageCommitDiff> {
  List<Diff> diffs;
  double _codeFontSize = 14.0;

  _loadDiffs() async {
    final resp =
        await ApiService.commitDiff(widget.projectId, widget.commit.id);
    if (resp.success) {
      if (mounted) {
        setState(() => diffs = resp.data);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _loadDiffs();
  }

  _buildFontControl() {
    return Row(
      children: <Widget>[
        Text(
          "Code Size: $_codeFontSize",
        ),
        OutlineButton(
          child: Text("-"),
          onPressed: () => setState(() => _codeFontSize -= 1),
        ),
        OutlineButton(
          child: Text("+"),
          onPressed: () => setState(() => _codeFontSize += 1),
        )
      ],
    );
  }

  _buildDiff(Diff item) {
    return Card(
        child: ExpansionTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                item.newFile
                    ? IgnorePointer()
                    : Text(
                        item.oldPath,
                        style: TextStyle(color: Colors.red),
                      ),
                item.deletedFile
                    ? IgnorePointer()
                    : Text(
                        item.newPath,
                        style: TextStyle(color: Colors.green),
                      ),
              ],
            ),
            children: [
          _buildFontControl(),
          Divider(color: Colors.grey),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: diffToText(item.diff, Colors.red, Colors.green,
                  Theme.of(context).textTheme.title.color,
                  fontSize: _codeFontSize),
            ),
          ),
        ]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.commit.title),
      ),
      body: diffs == null
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: diffs.length,
              itemBuilder: (context, index) {
                final item = diffs[index];
                return _buildDiff(item);
              }),
    );
  }
}
