import 'dart:convert';

import 'package:F4Lab/gitlab_client.dart';
import 'package:F4Lab/model/user.dart';
import 'package:http/http.dart';

class ApiService {
  static Map<String, dynamic> respConvertToMap(Response resp) {
    if (resp.statusCode / 100 != 2) {
      throw Exception("Response error: ${resp.statusCode} ${resp.body}");
    }
    return jsonDecode(resp.body);
  }

  static Future<User> getAuthUser() async {
    final client = GitlabClient();
    return client
        .get('user')
        .then(respConvertToMap)
        .then((jsonResp) => User.fromJson(jsonResp))
        .catchError(print)
        .whenComplete(client.close);
  }
}
