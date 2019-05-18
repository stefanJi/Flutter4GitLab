import 'package:F4Lab/api.dart' show ApiEndPoint;
import 'package:F4Lab/model/commit.dart';
import 'package:F4Lab/model/discussion.dart';
import 'package:F4Lab/ui/page/PageCommitDiff.dart';
import 'package:F4Lab/util/date_util.dart';
import 'package:F4Lab/util/widget_util.dart';
import 'package:F4Lab/widget/comm_ListView.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CommitTab extends CommListWidget {
  final int projectId;
  final int mrIId;

  CommitTab(this.projectId, this.mrIId);

  @override
  State<StatefulWidget> createState() => _CommitState();
}

class _CommitState extends CommListState<CommitTab> {
  @override
  Widget childBuild(BuildContext context, int index) {
    final Commit commit = Commit.fromJson(data[index]);
    return Card(
      child: ListTile(
        title: Text(commit.title),
        subtitle: Text(datetime2String(commit.createdAt)),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => PageCommitDiff(widget.projectId, commit)));
        },
      ),
    );
  }

  @override
  String endPoint() =>
      ApiEndPoint.mergeRequestCommit(widget.projectId, widget.mrIId);
}

class DiscussionTab extends CommListWidget {
  final int projectId;
  final int mrIId;

  DiscussionTab(this.projectId, this.mrIId);

  @override
  State<StatefulWidget> createState() => _DiscussionState();
}

class _DiscussionState extends CommListState<DiscussionTab> {
  @override
  Widget childBuild(BuildContext context, int index) {
    final Discussion discussion = Discussion.fromJson(data[index]);
    final List<Notes> notes = List();
    discussion.notes.forEach((note) {
      if (!note.system) {
        notes.add(note);
      }
    });

    final items = notes.map<Widget>((item) {
      return ListTile(
        isThreeLine: true,
        title: Text(item.body ?? ""),
        subtitle: Text(item.author.name ?? ""),
        leading: loadAvatar(item.author.avatarUrl, item.author.name),
        trailing: Icon(
          item.resolved ? Icons.check_circle : Icons.error_outline,
          color: item.resolved ? Colors.green : Colors.redAccent,
          semanticLabel: "Resolved?",
        ),
      );
    }).toList();

    return Card(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items,
    ));
  }

  @override
  String endPoint() =>
      ApiEndPoint.mergeRequestDiscussion(widget.projectId, widget.mrIId);

  @override
  bool itemShouldRemove(dynamic item) =>
      Discussion.fromJson(item).individualNote;
}
