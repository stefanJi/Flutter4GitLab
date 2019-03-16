import 'package:F4Lab/model/pipeline.dart';
import 'package:F4Lab/model/runner.dart';
import 'package:F4Lab/model/user.dart';

class Jobs {
  Commit commit;
  String coverage;
  String createdAt;
  String startedAt;
  String finishedAt;
  double duration;
  String artifactsExpireAt;
  int id;
  String name;
  Pipeline pipeline;
  String ref;
  List<String> artifacts;
  Runner runner;
  String stage;
  String status;
  bool tag;
  String webUrl;
  User user;

  Jobs(
      {this.commit,
      this.coverage,
      this.createdAt,
      this.startedAt,
      this.finishedAt,
      this.duration,
      this.artifactsExpireAt,
      this.id,
      this.name,
      this.pipeline,
      this.ref,
      this.artifacts,
      this.runner,
      this.stage,
      this.status,
      this.tag,
      this.webUrl,
      this.user});

  Jobs.fromJson(Map<String, dynamic> json) {
    commit =
        json['commit'] != null ? new Commit.fromJson(json['commit']) : null;
    coverage = json['coverage'];
    createdAt = json['created_at'];
    startedAt = json['started_at'];
    finishedAt = json['finished_at'];
    duration = json['duration'];
    artifactsExpireAt = json['artifacts_expire_at'];
    id = json['id'];
    name = json['name'];
    pipeline = json['pipeline'] != null
        ? new Pipeline.fromJson(json['pipeline'])
        : null;
    ref = json['ref'];
    artifacts = json['artifacts'].cast<String>();
    runner = Runner.fromJson(json['runner']);
    stage = json['stage'];
    status = json['status'];
    tag = json['tag'];
    webUrl = json['web_url'];
    user = json['user'] != null ? new User.fromJsonInJobs(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.commit != null) {
      data['commit'] = this.commit.toJson();
    }
    data['coverage'] = this.coverage;
    data['created_at'] = this.createdAt;
    data['started_at'] = this.startedAt;
    data['finished_at'] = this.finishedAt;
    data['duration'] = this.duration;
    data['artifacts_expire_at'] = this.artifactsExpireAt;
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.pipeline != null) {
      data['pipeline'] = this.pipeline.toJson();
    }
    data['ref'] = this.ref;
    data['artifacts'] = this.artifacts;
    data['runner'] = this.runner.toJson();
    data['stage'] = this.stage;
    data['status'] = this.status;
    data['tag'] = this.tag;
    data['web_url'] = this.webUrl;
    if (this.user != null) {
      data['user'] = this.user.toJsonInJobs();
    }
    return data;
  }
}

class Commit {
  String authorEmail;
  String authorName;
  String createdAt;
  String id;
  String message;
  String shortId;
  String title;

  Commit(
      {this.authorEmail,
      this.authorName,
      this.createdAt,
      this.id,
      this.message,
      this.shortId,
      this.title});

  Commit.fromJson(Map<String, dynamic> json) {
    authorEmail = json['author_email'];
    authorName = json['author_name'];
    createdAt = json['created_at'];
    id = json['id'];
    message = json['message'];
    shortId = json['short_id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['author_email'] = this.authorEmail;
    data['author_name'] = this.authorName;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    data['message'] = this.message;
    data['short_id'] = this.shortId;
    data['title'] = this.title;
    return data;
  }
}
