import 'package:F4Lab/api.dart';
import 'package:F4Lab/model/jobs.dart';
import 'package:F4Lab/widget/comm_ListView.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class JobsTab extends CommListWidget {
  final int projectId;

  JobsTab(this.projectId);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends CommListState<JobsTab> {
  @override
  Widget childBuild(BuildContext context, int index) {
    return JobWidget(job: Jobs.fromJson(data[index]));
  }

  @override
  String endPoint() => ApiEndPoint.projectJobs(widget.projectId);
}

class JobWidget extends StatelessWidget {
  final Jobs job;

  const JobWidget({Key key, this.job}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("#${job.id} ${job.ref} ${job.user.name}"),
          Text(job.status),
          Text(job.stage),
          Text(job.name),
        ],
      ),
    ));
  }
}
