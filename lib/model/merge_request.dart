class MergeRequest {
  int id;
  int iid;
  int projectId;
  String title;
  String description;
  String state;
  MergedBy mergedBy;
  String mergedAt;
  String closedBy;
  String closedAt;
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
  String sha;
  String mergeCommitSha;
  int userNotesCount;
  String discussionLocked;
  bool shouldRemoveSourceBranch;
  bool forceRemoveSourceBranch;
  bool allowCollaboration;
  bool allowMaintainerToPush;
  String webUrl;
  TimeStats timeStats;
  bool squash;
  int approvalsBeforeMerge;

  MergeRequest(
      {this.id,
      this.iid,
      this.projectId,
      this.title,
      this.description,
      this.state,
      this.mergedBy,
      this.mergedAt,
      this.closedBy,
      this.closedAt,
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
      this.sha,
      this.mergeCommitSha,
      this.userNotesCount,
      this.discussionLocked,
      this.shouldRemoveSourceBranch,
      this.forceRemoveSourceBranch,
      this.allowCollaboration,
      this.allowMaintainerToPush,
      this.webUrl,
      this.timeStats,
      this.squash,
      this.approvalsBeforeMerge});

  MergeRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    iid = json['iid'];
    projectId = json['project_id'];
    title = json['title'];
    description = json['description'];
    state = json['state'];
    mergedBy = json['merged_by'] != null
        ? new MergedBy.fromJson(json['merged_by'])
        : null;
    mergedAt = json['merged_at'];
    closedBy = json['closed_by'];
    closedAt = json['closed_at'];
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
    sha = json['sha'];
    mergeCommitSha = json['merge_commit_sha'];
    userNotesCount = json['user_notes_count'];
    discussionLocked = json['discussion_locked'];
    shouldRemoveSourceBranch = json['should_remove_source_branch'];
    forceRemoveSourceBranch = json['force_remove_source_branch'];
    allowCollaboration = json['allow_collaboration'];
    allowMaintainerToPush = json['allow_maintainer_to_push'];
    webUrl = json['web_url'];
    timeStats = json['time_stats'] != null
        ? new TimeStats.fromJson(json['time_stats'])
        : null;
    squash = json['squash'];
    approvalsBeforeMerge = json['approvals_before_merge'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['iid'] = this.iid;
    data['project_id'] = this.projectId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['state'] = this.state;
    if (this.mergedBy != null) {
      data['merged_by'] = this.mergedBy.toJson();
    }
    data['merged_at'] = this.mergedAt;
    data['closed_by'] = this.closedBy;
    data['closed_at'] = this.closedAt;
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
    data['sha'] = this.sha;
    data['merge_commit_sha'] = this.mergeCommitSha;
    data['user_notes_count'] = this.userNotesCount;
    data['discussion_locked'] = this.discussionLocked;
    data['should_remove_source_branch'] = this.shouldRemoveSourceBranch;
    data['force_remove_source_branch'] = this.forceRemoveSourceBranch;
    data['allow_collaboration'] = this.allowCollaboration;
    data['allow_maintainer_to_push'] = this.allowMaintainerToPush;
    data['web_url'] = this.webUrl;
    if (this.timeStats != null) {
      data['time_stats'] = this.timeStats.toJson();
    }
    data['squash'] = this.squash;
    data['approvals_before_merge'] = this.approvalsBeforeMerge;
    return data;
  }
}

class MergedBy {
  int id;
  String name;
  String username;
  String state;
  String avatarUrl;
  String webUrl;

  MergedBy(
      {this.id,
      this.name,
      this.username,
      this.state,
      this.avatarUrl,
      this.webUrl});

  MergedBy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    state = json['state'];
    avatarUrl = json['avatar_url'];
    webUrl = json['web_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['username'] = this.username;
    data['state'] = this.state;
    data['avatar_url'] = this.avatarUrl;
    data['web_url'] = this.webUrl;
    return data;
  }
}

class Author {
  int id;
  String name;
  String username;
  String state;
  String avatarUrl;
  String webUrl;

  Author(
      {this.id,
      this.name,
      this.username,
      this.state,
      this.avatarUrl,
      this.webUrl});

  Author.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    state = json['state'];
    avatarUrl = json['avatar_url'];
    webUrl = json['web_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['username'] = this.username;
    data['state'] = this.state;
    data['avatar_url'] = this.avatarUrl;
    data['web_url'] = this.webUrl;
    return data;
  }
}

class Assignee {
  int id;
  String name;
  String username;
  String state;
  String avatarUrl;
  String webUrl;

  Assignee(
      {this.id,
      this.name,
      this.username,
      this.state,
      this.avatarUrl,
      this.webUrl});

  Assignee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    state = json['state'];
    avatarUrl = json['avatar_url'];
    webUrl = json['web_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['username'] = this.username;
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
  String startDate;
  String webUrl;

  Milestone(
      {this.id,
      this.iid,
      this.projectId,
      this.title,
      this.description,
      this.state,
      this.createdAt,
      this.updatedAt,
      this.dueDate,
      this.startDate,
      this.webUrl});

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
    startDate = json['start_date'];
    webUrl = json['web_url'];
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
    data['start_date'] = this.startDate;
    data['web_url'] = this.webUrl;
    return data;
  }
}

class TimeStats {
  int timeEstimate;
  int totalTimeSpent;
  int humanTimeEstimate;
  int humanTotalTimeSpent;

  TimeStats(
      {this.timeEstimate,
      this.totalTimeSpent,
      this.humanTimeEstimate,
      this.humanTotalTimeSpent});

  TimeStats.fromJson(Map<String, dynamic> json) {
    timeEstimate = json['time_estimate'];
    totalTimeSpent = json['total_time_spent'];
    humanTimeEstimate = json['human_time_estimate'];
    humanTotalTimeSpent = json['human_total_time_spent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time_estimate'] = this.timeEstimate;
    data['total_time_spent'] = this.totalTimeSpent;
    data['human_time_estimate'] = this.humanTimeEstimate;
    data['human_total_time_spent'] = this.humanTotalTimeSpent;
    return data;
  }
}
