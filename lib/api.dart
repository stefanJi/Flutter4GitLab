import 'dart:convert';

import 'package:F4Lab/gitlab_client.dart';
import 'package:F4Lab/model/user.dart';
import 'package:http/http.dart';

class ApiResp<T> {
  bool success;
  T data;

  ApiResp(this.success, {this.data});
}

class ApiEndPoint {
  static String mergeRequestCommit(int projectId, int mrIID) =>
      "projects/$projectId/merge_requests/$mrIID/commits";

  static String approveMergeRequest(int projectId, int mrIId, bool approve) =>
      "projects/$projectId/merge_requests/$mrIId/${approve ? "approve" : "unapprove"}";
}

class ApiService {
  static Map<String, dynamic> respConvertToMap(Response resp) {
    if (resp.statusCode / 100 != 2) {
      throw Exception("Response error: ${resp.statusCode} ${resp.body}");
    }
    return jsonDecode(resp.body);
  }

  static Future<User> getAuthUser() async {
    final client = GitlabClient.newInstance();
    return client
        .get('user')
        .then(respConvertToMap)
        .then((jsonResp) => User.fromJson(jsonResp))
        .catchError(print)
        .whenComplete(client.close);
  }

  static Future<ApiResp> approve(
      int projectId, int mrIId, bool isApprove) async {
    final endPoint =
        ApiEndPoint.approveMergeRequest(projectId, mrIId, isApprove);
    final client = GitlabClient.newInstance();
    return client
        .post(endPoint)
        .then((resp) {
          return ApiResp<String>(
            (resp.statusCode ~/ 100) == 2,
            data: resp.body,
          );
        })
        .catchError(print)
        .whenComplete(client.close);
  }
}
