import 'package:F4Lab/model/user.dart';

class Pipeline {
  int id;
  String sha;
  String ref;
  String status;
  String webUrl;
  String beforeSha;
  bool tag;
  String yamlErrors;
  User user;
  String createdAt;
  String updatedAt;
  String startedAt;
  String finishedAt;
  String committedAt;
  int duration;
  String coverage;

  Pipeline(
      {this.id,
      this.sha,
      this.ref,
      this.status,
      this.webUrl,
      this.beforeSha,
      this.tag,
      this.yamlErrors,
      this.user,
      this.createdAt,
      this.updatedAt,
      this.startedAt,
      this.finishedAt,
      this.committedAt,
      this.duration,
      this.coverage});

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
      data['user'] = this.user.toJson();
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
