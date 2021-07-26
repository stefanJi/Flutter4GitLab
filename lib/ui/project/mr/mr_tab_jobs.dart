import 'package:F4Lab/api.dart';
import 'package:F4Lab/model/jobs.dart';
import 'package:F4Lab/model/pipeline.dart';
import 'package:F4Lab/util/date_util.dart';
import 'package:F4Lab/widget/comm_ListView.dart';
import 'package:flutter/material.dart';

class MergeRequestJobsTab extends CommListWidget {
  final int projectId;
  final int mrIId;

  MergeRequestJobsTab(this.projectId, this.mrIId);

  @override
  State<StatefulWidget> createState() => _JobsState();
}

class _JobsState extends CommListState<MergeRequestJobsTab> {
  @override
  Widget childBuild(BuildContext context, int index) {
    final pipeline = Pipeline.fromJson(data[index]);
    return _PipelineJobs(widget.projectId, pipeline.id, index);
  }

  @override
  String endPoint() =>
      ApiEndPoint.mergeRequestPipelines(widget.projectId, widget.mrIId);
}

class _PipelineJobs extends StatefulWidget {
  final int pipelineId;
  final int projectId;
  final int index;

  _PipelineJobs(this.projectId, this.pipelineId, this.index);

  @override
  State<StatefulWidget> createState() => _PipelineJobsState();
}

class _PipelineJobsState extends State<_PipelineJobs> {
  bool _loading = true;
  List<Jobs> _jobs = [];

  final colors = {
    'created': Colors.teal,
    'pending': Colors.grey,
    'running': Colors.teal,
    'failed': Colors.red,
    'success': Colors.green,
    'canceled': Colors.grey,
    'skipped': Colors.grey,
    'manual': Colors.blue
  };

  _loadJobs() async {
    setState(() {
      _loading = true;
      _jobs = [];
    });
    final apiResp =
        await ApiService.pipelineJobs(widget.projectId, widget.pipelineId);
    if (mounted) {
      setState(() {
        _loading = false;
        final data = apiResp.data
          ?..sort((j1, j2) => j2.createdAt.compareTo(j1.createdAt));
        data?.forEach((element) {
          _jobs.add(element);
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadJobs();
  }

  Widget _buildStatus(Jobs job) {
    return Chip(
      label: Text(
        job.status,
      ),
      labelStyle: TextStyle(color: colors[job.status]),
    );
  }

  Widget _buildAction(Jobs item) {
    Widget buildBtn() {
      switch (item.status) {
        case 'skipped':
        case 'pending':
          return IgnorePointer();
        case 'running':
          return OutlinedButton(
              child: const Text("cancel"),
              onPressed: () => _doAction(widget.projectId, item.id, 'cancel'));
        case 'failed':
        case 'success':
          return OutlinedButton(
              child: const Text("retry"),
              onPressed: () => _doAction(widget.projectId, item.id, 'retry'));
        case 'created':
        case 'canceled':
        case 'manual':
          return OutlinedButton(
              child: const Text("play"),
              onPressed: () => _doAction(widget.projectId, item.id, 'play'));
      }
      return IgnorePointer();
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          item.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        buildBtn()
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).cardColor;
    return _loading
        ? LinearProgressIndicator()
        : Card(
            color: widget.index.isOdd
                ? Color.fromRGBO(
                    color.red, color.green, color.blue, color.opacity - 0.2)
                : color,
            margin: EdgeInsets.only(bottom: 20, left: 4, right: 4, top: 10),
            child: Padding(
                padding: EdgeInsets.only(left: 5, right: 5),
                child: Column(
                  children: _jobs.map<Widget>((job) {
                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                  flex: 3,
                                  child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "${job.commit?.title.substring(0, 1).toUpperCase()}${job.commit?.title.substring(1)}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                        Padding(
                                          child: Text(
                                              datetime2String(job.createdAt)),
                                          padding: const EdgeInsets.all(5),
                                        ),
                                        Padding(
                                          child: Text(job.user?.name ?? ""),
                                          padding: const EdgeInsets.all(5),
                                        ),
                                      ])),
                              Expanded(flex: 1, child: _buildStatus(job)),
                            ],
                          ),
                          _buildAction(job),
                          Divider()
                        ]);
                  }).toList(),
                )));
  }

  _doAction(projectId, int jobId, String action) async {
    _loading = true;
    final resp = await ApiService.triggerPipelineJob(projectId, jobId, action);
    if (mounted) {
      setState(() => _loading = false);
    }
    if (!resp.success) {
    } else {
      _loadJobs();
    }
  }
}
