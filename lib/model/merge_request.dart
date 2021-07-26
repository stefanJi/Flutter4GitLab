class MergeRequest {
  late int id;
  late int iid;
  late int projectId;
  late String title;
  late String description;
  late String state;
  MergedBy? mergedBy;
  late String? mergedAt;
  Author? closedBy;
  late String? closedAt;
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
  late String sha;
  String? mergeCommitSha;
  late int userNotesCount;
  String? discussionLocked;
  bool? shouldRemoveSourceBranch;
  late bool forceRemoveSourceBranch;
  late bool allowCollaboration;
  late bool allowMaintainerToPush;
  late String webUrl;
  TimeStats? timeStats;
  late bool squash;
  late int divergedCommitsCount;
  late bool rebaseInProgress;

  MergeRequest(
      {required this.id,
      required this.iid,
      required this.projectId,
      required this.title,
      required this.description,
      required this.state,
      this.mergedBy,
      required this.mergedAt,
      this.closedBy,
      this.closedAt,
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
      required this.sha,
      this.mergeCommitSha,
      required this.userNotesCount,
      this.discussionLocked,
      this.shouldRemoveSourceBranch,
      required this.forceRemoveSourceBranch,
      required this.allowCollaboration,
      required this.allowMaintainerToPush,
      required this.webUrl,
      this.timeStats,
      required this.squash,
      required this.divergedCommitsCount,
      required this.rebaseInProgress});

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
    closedBy =
        json['closed_by'] != null ? Author.fromJson(json['closed_by']) : null;
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
    labels = (json['labels'] ?? []).cast<String>();
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
    webUrl = json['web_url'];
    timeStats = json['time_stats'] != null
        ? new TimeStats.fromJson(json['time_stats'])
        : null;
    squash = json['squash'];
    divergedCommitsCount = json['diverged_commits_count'] != null
        ? json['diverged_commits_count']
        : 0;
    rebaseInProgress = json['rebase_in_progress'] ?? false;
  }
}

class MergedBy {
  late int id;
  late String name;
  late String username;
  late String state;
  late String avatarUrl;
  late String webUrl;

  MergedBy(
      {required this.id,
      required this.name,
      required this.username,
      required this.state,
      required this.avatarUrl,
      required this.webUrl});

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
  late int id;
  late String name;
  late String username;
  late String state;
  late String avatarUrl;
  late String webUrl;

  Author(
      {required this.id,
      required this.name,
      required this.username,
      required this.state,
      required this.avatarUrl,
      required this.webUrl});

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
  late int id;
  late String name;
  late String username;
  late String state;
  late String avatarUrl;
  late String webUrl;

  Assignee(
      {required this.id,
      required this.name,
      required this.username,
      required this.state,
      required this.avatarUrl,
      required this.webUrl});

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
  late int id;
  late int iid;
  late int projectId;
  late String title;
  late String description;
  late String state;
  late String createdAt;
  late String updatedAt;
  late String dueDate;
  late String startDate;
  late String webUrl;

  Milestone(
      {required this.id,
      required this.iid,
      required this.projectId,
      required this.title,
      required this.description,
      required this.state,
      required this.createdAt,
      required this.updatedAt,
      required this.dueDate,
      required this.startDate,
      required this.webUrl});

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
  late int timeEstimate;
  late int totalTimeSpent;
  int? humanTimeEstimate;
  int? humanTotalTimeSpent;

  TimeStats(
      {required this.timeEstimate,
      required this.totalTimeSpent,
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
