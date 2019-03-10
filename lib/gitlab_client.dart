import 'dart:convert';

import 'package:http/http.dart' as http;

const API_VERSION = 'v4';

class GitlabClient extends http.BaseClient {
  static String globalHOST;
  static String _globalTOKEN;

  final http.Client _inner = http.Client();

  static GitlabClient newInstance() => GitlabClient();

  static setUpTokenAndHost(String token, String host) {
    _globalTOKEN = token;
    globalHOST = host;
  }

  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers['Private-Token'] = _globalTOKEN;
    request.headers['User-Agent'] = 'F4Lab';
    return _inner.send(request);
  }

  @override
  Future<http.Response> get(endPoint, {Map<String, String> headers}) {
    return super.get(getRequestUrl(endPoint), headers: headers);
  }

  Future<http.Response> getRss(endPoint, {Map<String, String> headers}) {
    return super.get("$globalHOST/$endPoint");
  }

  @override
  Future<http.Response> post(endPoint,
      {Map<String, String> headers, body, Encoding encoding}) {
    return super.post(getRequestUrl(endPoint),
        headers: headers, body: body, encoding: encoding);
  }

  @override
  Future<http.Response> put(url,
      {Map<String, String> headers, body, Encoding encoding}) {
    return super.put(getRequestUrl(url),
        headers: headers, body: body, encoding: encoding);
  }

  String getRequestUrl(String endPoint) =>
      "$globalHOST/api/$API_VERSION/$endPoint";
}
