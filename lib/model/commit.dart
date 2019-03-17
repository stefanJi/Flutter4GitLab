import 'package:F4Lab/util/date_util.dart';

class Commit {
  String id;
  String shortId;
  String title;
  String authorName;
  String authorEmail;
  DateTime createdAt;
  String message;

  Commit(
      {this.id,
      this.shortId,
      this.title,
      this.authorName,
      this.authorEmail,
      this.createdAt,
      this.message});

  Commit.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    shortId = json['short_id'];
    title = json['title'];
    authorName = json['author_name'];
    authorEmail = json['author_email'];
    createdAt = string2Datetime(json['created_at']);
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['short_id'] = this.shortId;
    data['title'] = this.title;
    data['author_name'] = this.authorName;
    data['author_email'] = this.authorEmail;
    data['created_at'] = this.createdAt;
    data['message'] = this.message;
    return data;
  }
}
