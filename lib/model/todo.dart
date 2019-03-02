class Todo {
  int id;
  Project project;
  Author author;
  String actionName;
  String targetType;
  Target target;
  String targetUrl;
  String body;
  String state;
  String createdAt;

  Todo(
      {this.id,
      this.project,
      this.author,
      this.actionName,
      this.targetType,
      this.target,
      this.targetUrl,
      this.body,
      this.state,
      this.createdAt});

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
      data['project'] = this.project.toJson();
    }
    if (this.author != null) {
      data['author'] = this.author.toJson();
    }
    data['action_name'] = this.actionName;
    data['target_type'] = this.targetType;
    if (this.target != null) {
      data['target'] = this.target.toJson();
    }
    data['target_url'] = this.targetUrl;
    data['body'] = this.body;
    data['state'] = this.state;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class Project {
  int id;
  String name;
  String nameWithNamespace;
  String path;
  String pathWithNamespace;

  Project(
      {this.id,
      this.name,
      this.nameWithNamespace,
      this.path,
      this.pathWithNamespace});

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
  String name;
  String username;
  int id;
  String state;
  String avatarUrl;
  String webUrl;

  Author(
      {this.name,
      this.username,
      this.id,
      this.state,
      this.avatarUrl,
      this.webUrl});

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
  int id;
  int iid;
  int projectId;
  String title;
  String description;
  String state;
  String createdAt;
  String updatedAt;
  String targetBranch;
  String sourceBranch;
  int upvotes;
  int downvotes;
  Author author;
  Assignee assignee;
  int sourceProjectId;
  int targetProjectId;
  List<String> labels;
  bool workInProgress;
  Milestone milestone;
  bool mergeWhenPipelineSucceeds;
  String mergeStatus;
  bool subscribed;
  int userNotesCount;

  Target(
      {this.id,
      this.iid,
      this.projectId,
      this.title,
      this.description,
      this.state,
      this.createdAt,
      this.updatedAt,
      this.targetBranch,
      this.sourceBranch,
      this.upvotes,
      this.downvotes,
      this.author,
      this.assignee,
      this.sourceProjectId,
      this.targetProjectId,
      this.labels,
      this.workInProgress,
      this.milestone,
      this.mergeWhenPipelineSucceeds,
      this.mergeStatus,
      this.subscribed,
      this.userNotesCount});

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
      data['author'] = this.author.toJson();
    }
    if (this.assignee != null) {
      data['assignee'] = this.assignee.toJson();
    }
    data['source_project_id'] = this.sourceProjectId;
    data['target_project_id'] = this.targetProjectId;
    data['labels'] = this.labels;
    data['work_in_progress'] = this.workInProgress;
    if (this.milestone != null) {
      data['milestone'] = this.milestone.toJson();
    }
    data['merge_when_pipeline_succeeds'] = this.mergeWhenPipelineSucceeds;
    data['merge_status'] = this.mergeStatus;
    data['subscribed'] = this.subscribed;
    data['user_notes_count'] = this.userNotesCount;
    return data;
  }
}

class Assignee {
  String name;
  String username;
  int id;
  String state;
  String avatarUrl;
  String webUrl;

  Assignee(
      {this.name,
      this.username,
      this.id,
      this.state,
      this.avatarUrl,
      this.webUrl});

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
  int id;
  int iid;
  int projectId;
  String title;
  String description;
  String state;
  String createdAt;
  String updatedAt;
  String dueDate;

  Milestone(
      {this.id,
      this.iid,
      this.projectId,
      this.title,
      this.description,
      this.state,
      this.createdAt,
      this.updatedAt,
      this.dueDate});

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
