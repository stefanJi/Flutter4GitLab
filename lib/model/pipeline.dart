import 'package:F4Lab/model/user.dart';

class Pipeline {
  late int id;
  late String sha;
  late String ref;
  late String status;
  late String webUrl;
  late String beforeSha;
  late bool tag;
  late String yamlErrors;
  User? user;
  late String createdAt;
  late String updatedAt;
  late String startedAt;
  late String finishedAt;
  late String committedAt;
  late int duration;
  late String coverage;

  Pipeline(
      {required this.id,
      required this.sha,
      required this.ref,
      required this.status,
      required this.webUrl,
      required this.beforeSha,
      required this.tag,
      required this.yamlErrors,
      this.user,
      required this.createdAt,
      required this.updatedAt,
      required this.startedAt,
      required this.finishedAt,
      required this.committedAt,
      required this.duration,
      required this.coverage});

  Pipeline.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sha = json['sha'];
    ref = json['ref'];
    status = json['status'];
    webUrl = json['web_url'];
    beforeSha = json['before_sha'];
    tag = json['tag'];
    yamlErrors = json['yaml_errors'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    startedAt = json['started_at'];
    finishedAt = json['finished_at'];
    committedAt = json['committed_at'];
    duration = json['duration'];
    coverage = json['coverage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sha'] = this.sha;
    data['ref'] = this.ref;
    data['status'] = this.status;
    data['web_url'] = this.webUrl;
    data['before_sha'] = this.beforeSha;
    data['tag'] = this.tag;
    data['yaml_errors'] = this.yamlErrors;
    if (this.user != null) {
      data['user'] = this.user?.toJson();
    }
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['started_at'] = this.startedAt;
    data['finished_at'] = this.finishedAt;
    data['committed_at'] = this.committedAt;
    data['duration'] = this.duration;
    data['coverage'] = this.coverage;
    return data;
  }
}
