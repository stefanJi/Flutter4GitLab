import 'package:F4Lab/util/date_util.dart';

class Commit {
  late String id;
  late String shortId;
  late String title;
  late String authorName;
  late String authorEmail;
  late DateTime createdAt;
  late String message;

  Commit(
      {required this.id,
      required this.shortId,
      required this.title,
      required this.authorName,
      required this.authorEmail,
      required this.createdAt,
      required this.message});

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
