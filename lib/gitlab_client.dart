import 'dart:convert';

import 'package:http/http.dart' as http;

const API_VERSION = 'v4';

class GitlabClient extends http.BaseClient {
  static String _globalHOST;
  static String _globalTOKEN;

  final http.Client _inner = http.Client();

  static GitlabClient newInstance() => GitlabClient();

  static setUpTokenAndHost(String token, String host) {
    _globalTOKEN = token;
    _globalHOST = host;
  }

  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers['Private-Token'] = _globalTOKEN;
    request.headers['user-agent'] = 'Gitlab Dart Client';
    return _inner.send(request);
  }

  @override
  Future<http.Response> get(endPoint, {Map<String, String> headers}) {
    return super.get(_generateUrl(endPoint), headers: headers);
  }

  @override
  Future<http.Response> post(endPoint,
      {Map<String, String> headers, body, Encoding encoding}) {
    return super.post(_generateUrl(endPoint),
        headers: headers, body: body, encoding: encoding);
  }

  String _generateUrl(String endPoint) =>
      "$_globalHOST/api/$API_VERSION/$endPoint";
}
