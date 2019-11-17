import 'package:F4Lab/model/project.dart' as model;
import 'package:F4Lab/ui/project/project_detail.dart';
import 'package:F4Lab/widget/comm_ListView.dart';
import 'package:flutter/material.dart';

const projectTypes = {
  "All": "membership=true",
  "Your": "owned=true",
  "Starred": "starred=true"
};

class TabProject extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: TabBar(
              labelColor: Theme.of(context).accentColor,
              indicatorColor: Theme.of(context).primaryColor,
              tabs:
                  projectTypes.keys.map((title) => Tab(text: title)).toList()),
          body: TabBarView(
              children: projectTypes.values
                  .map((option) => ProjectTab(option))
                  .toList()),
        ));
  }
}

class ProjectTab extends CommListWidget {
  final String type;

  ProjectTab(this.type);

  @override
  State<StatefulWidget> createState() => ProjectState();
}

class ProjectState extends CommListState<ProjectTab> {
  @override
  Widget childBuild(BuildContext context, int index) {
    final item = model.Project.fromJson(data[index]);
    return Card(
      child: ListTile(
        leading: item.avatarUrl != null
            ? CircleAvatar(
                backgroundImage: NetworkImage(item.avatarUrl),
                backgroundColor: Theme.of(context).primaryColor,
              )
            : CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor,
                child: Text(
                  item.name.substring(0, 1).toUpperCase(),
                  style: TextStyle(color: Theme.of(context).accentColor),
                ),
              ),
        title: Text(item.nameWithNamespace),
        subtitle: Text(item.description ?? item.lastActivityAt),
        trailing: item.defaultBranch != null
            ? Chip(
                label: Text(item.defaultBranch,
                    style: TextStyle(color: Theme.of(context).primaryColor)),
                backgroundColor: Theme.of(context).backgroundColor,
              )
            : IgnorePointer(
                ignoring: true,
              ),
        onTap: () {
          _navToProjectDetail(item.name, item.id);
        },
      ),
    );
  }

  _navToProjectDetail(String name, int projectId) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PageProjectDetail(name, projectId)));
  }

  @override
  String endPoint() =>
      "projects?order_by=updated_at&per_page=10&simple=true&${widget.type}";
}
