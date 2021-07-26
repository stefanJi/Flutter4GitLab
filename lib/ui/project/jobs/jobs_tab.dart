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

  const JobWidget({Key? key, required this.job}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(child: Padding(padding: EdgeInsets.all(8), child: _item(job)));
  }

  Widget _item(Jobs job) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(job.commit?.title ?? "",
            style: TextStyle(fontWeight: FontWeight.bold)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text("#${job.id} ${job.ref}"),
            Row(
              children: <Widget>[
                Padding(
                  child: Text(job.status),
                  padding: EdgeInsets.all(3),
                ),
                statusIcons.containsKey(job.status)
                    ? statusIcons[job.status]
                    : Icon(Icons.error, size: 18)
              ],
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(job.stage),
            Text(job.name),
          ],
        ),
      ],
    );
  }

  static get statusIcons => {
        "success": Icon(Icons.check_circle, color: Colors.green, size: 18),
        "manual": Icon(Icons.build, size: 18),
        "failed": Icon(Icons.error_outline, color: Colors.redAccent, size: 18),
        "skipped": Icon(Icons.skip_next, size: 18),
        "canceled": Icon(Icons.cancel, size: 18)
      };
}
