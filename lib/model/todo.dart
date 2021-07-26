class Todo {
  late int id;
  Project? project;
  Author? author;
  late String actionName;
  late String targetType;
  Target? target;
  late String targetUrl;
  late String body;
  late String state;
  late String createdAt;

  Todo(
      {required this.id,
      this.project,
      this.author,
      required this.actionName,
      required this.targetType,
      this.target,
      required this.targetUrl,
      required this.body,
      required this.state,
      required this.createdAt});

  Todo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    project =
        json['project'] != null ? new Project.fromJson(json['project']) : null;
    author =
        json['author'] != null ? new Author.fromJson(json['author']) : null;
    actionName = json['action_name'];
    targetType = json['target_type'];
    target =
        json['target'] != null ? new Target.fromJson(json['target']) : null;
    targetUrl = json['target_url'];
    body = json['body'];
    state = json['state'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.project != null) {
      data['project'] = this.project?.toJson();
    }
    if (this.author != null) {
      data['author'] = this.author?.toJson();
    }
    data['action_name'] = this.actionName;
    data['target_type'] = this.targetType;
    if (this.target != null) {
      data['target'] = this.target?.toJson();
    }
    data['target_url'] = this.targetUrl;
    data['body'] = this.body;
    data['state'] = this.state;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class Project {
  late int id;
  late String name;
  late String nameWithNamespace;
  late String path;
  late String pathWithNamespace;

  Project(
      {required this.id,
      required this.name,
      required this.nameWithNamespace,
      required this.path,
      required this.pathWithNamespace});

  Project.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nameWithNamespace = json['name_with_namespace'];
    path = json['path'];
    pathWithNamespace = json['path_with_namespace'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['name_with_namespace'] = this.nameWithNamespace;
    data['path'] = this.path;
    data['path_with_namespace'] = this.pathWithNamespace;
    return data;
  }
}

class Author {
  late String name;
  late String username;
  late int id;
  late String state;
  late String avatarUrl;
  late String webUrl;

  Author(
      {required this.name,
      required this.username,
      required this.id,
      required this.state,
      required this.avatarUrl,
      required this.webUrl});

  Author.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    username = json['username'];
    id = json['id'];
    state = json['state'];
    avatarUrl = json['avatar_url'];
    webUrl = json['web_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['username'] = this.username;
    data['id'] = this.id;
    data['state'] = this.state;
    data['avatar_url'] = this.avatarUrl;
    data['web_url'] = this.webUrl;
    return data;
  }
}

class Target {
  late int id;
  late int iid;
  late int projectId;
  late String title;
  late String description;
  late String state;
  late String createdAt;
  late String updatedAt;
  late String targetBranch;
  late String sourceBranch;
  late int upvotes;
  late int downvotes;
  Author? author;
  Assignee? assignee;
  late int sourceProjectId;
  late int targetProjectId;
  late List<String> labels;
  late bool workInProgress;
  Milestone? milestone;
  late bool mergeWhenPipelineSucceeds;
  late String mergeStatus;
  late bool subscribed;
  late int userNotesCount;

  Target(
      {required this.id,
      required this.iid,
      required this.projectId,
      required this.title,
      required this.description,
      required this.state,
      required this.createdAt,
      required this.updatedAt,
      required this.targetBranch,
      required this.sourceBranch,
      required this.upvotes,
      required this.downvotes,
      this.author,
      this.assignee,
      required this.sourceProjectId,
      required this.targetProjectId,
      required this.labels,
      required this.workInProgress,
      this.milestone,
      required this.mergeWhenPipelineSucceeds,
      required this.mergeStatus,
      required this.subscribed,
      required this.userNotesCount});

  Target.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    iid = json['iid'];
    projectId = json['project_id'];
    title = json['title'];
    description = json['description'];
    state = json['state'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    targetBranch = json['target_branch'];
    sourceBranch = json['source_branch'];
    upvotes = json['upvotes'];
    downvotes = json['downvotes'];
    author =
        json['author'] != null ? new Author.fromJson(json['author']) : null;
    assignee = json['assignee'] != null
        ? new Assignee.fromJson(json['assignee'])
        : null;
    sourceProjectId = json['source_project_id'];
    targetProjectId = json['target_project_id'];
    labels = json['labels'].cast<String>();
    workInProgress = json['work_in_progress'];
    milestone = json['milestone'] != null
        ? new Milestone.fromJson(json['milestone'])
        : null;
    mergeWhenPipelineSucceeds = json['merge_when_pipeline_succeeds'];
    mergeStatus = json['merge_status'];
    subscribed = json['subscribed'];
    userNotesCount = json['user_notes_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['iid'] = this.iid;
    data['project_id'] = this.projectId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['state'] = this.state;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['target_branch'] = this.targetBranch;
    data['source_branch'] = this.sourceBranch;
    data['upvotes'] = this.upvotes;
    data['downvotes'] = this.downvotes;
    if (this.author != null) {
      data['author'] = this.author?.toJson();
    }
    if (this.assignee != null) {
      data['assignee'] = this.assignee?.toJson();
    }
    data['source_project_id'] = this.sourceProjectId;
    data['target_project_id'] = this.targetProjectId;
    data['labels'] = this.labels;
    data['work_in_progress'] = this.workInProgress;
    if (this.milestone != null) {
      data['milestone'] = this.milestone?.toJson();
    }
    data['merge_when_pipeline_succeeds'] = this.mergeWhenPipelineSucceeds;
    data['merge_status'] = this.mergeStatus;
    data['subscribed'] = this.subscribed;
    data['user_notes_count'] = this.userNotesCount;
    return data;
  }
}

class Assignee {
  late String name;
  late String username;
  late int id;
  late String state;
  late String avatarUrl;
  late String webUrl;

  Assignee(
      {required this.name,
      required this.username,
      required this.id,
      required this.state,
      required this.avatarUrl,
      required this.webUrl});

  Assignee.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    username = json['username'];
    id = json['id'];
    state = json['state'];
    avatarUrl = json['avatar_url'];
    webUrl = json['web_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['username'] = this.username;
    data['id'] = this.id;
    data['state'] = this.state;
    data['avatar_url'] = this.avatarUrl;
    data['web_url'] = this.webUrl;
    return data;
  }
}

class Milestone {
  late int id;
  late int iid;
  late int projectId;
  late String title;
  late String description;
  late String state;
  late String createdAt;
  late String updatedAt;
  late String dueDate;

  Milestone(
      {required this.id,
      required this.iid,
      required this.projectId,
      required this.title,
      required this.description,
      required this.state,
      required this.createdAt,
      required this.updatedAt,
      required this.dueDate});

  Milestone.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    iid = json['iid'];
    projectId = json['project_id'];
    title = json['title'];
    description = json['description'];
    state = json['state'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    dueDate = json['due_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['iid'] = this.iid;
    data['project_id'] = this.projectId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['state'] = this.state;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['due_date'] = this.dueDate;
    return data;
  }
}
