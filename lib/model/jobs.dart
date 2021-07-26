import 'package:F4Lab/model/pipeline.dart';
import 'package:F4Lab/model/runner.dart';
import 'package:F4Lab/model/user.dart';
import 'package:F4Lab/util/date_util.dart';

class Jobs {
  Commit? commit;
  late String coverage;
  late DateTime createdAt;
  late String startedAt;
  late String finishedAt;
  late double duration;
  late String artifactsExpireAt;
  late int id;
  late String name;
  Pipeline? pipeline;
  late String ref;
  late List<String> artifacts;
  late Runner runner;
  late String stage;
  late String status;
  late bool tag;
  late String webUrl;
  User? user;

  Jobs(
      {required this.commit,
      required this.coverage,
      required this.createdAt,
      required this.startedAt,
      required this.finishedAt,
      required this.duration,
      required this.artifactsExpireAt,
      required this.id,
      required this.name,
      this.pipeline,
      required this.ref,
      required this.artifacts,
      required this.runner,
      required this.stage,
      required this.status,
      required this.tag,
      required this.webUrl,
      this.user});

  Jobs.fromJson(Map<String, dynamic> json) {
    commit =
        json['commit'] != null ? new Commit.fromJson(json['commit']) : null;
    coverage = json['coverage'];
    createdAt = string2Datetime(json['created_at']);
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
      data['commit'] = this.commit?.toJson();
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
      data['pipeline'] = this.pipeline?.toJson();
    }
    data['ref'] = this.ref;
    data['artifacts'] = this.artifacts;
    data['runner'] = this.runner.toJson();
    data['stage'] = this.stage;
    data['status'] = this.status;
    data['tag'] = this.tag;
    data['web_url'] = this.webUrl;
    if (this.user != null) {
      data['user'] = this.user?.toJsonInJobs();
    }
    return data;
  }
}

class Commit {
  late String authorEmail;
  late String authorName;
  late String createdAt;
  late String id;
  late String message;
  late String shortId;
  late String title;

  Commit(
      {required this.authorEmail,
      required this.authorName,
      required this.createdAt,
      required this.id,
      required this.message,
      required this.shortId,
      required this.title});

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
