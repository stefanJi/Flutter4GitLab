import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

const DEFAULT_API_VERSION = 'v4';
const USER_AGENT = "F4Lab";

class GitlabClient extends http.BaseClient {
  static String globalHOST;
  static String globalTOKEN;
  static String apiVersion;

  final http.Client _inner = http.Client();

  static GitlabClient newInstance() => GitlabClient();

  static setUpTokenAndHost(String token, String host, String version) {
    globalTOKEN = token;
    globalHOST = host;
    apiVersion = version;
  }

  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers['Private-Token'] = globalTOKEN;
    request.headers['User-Agent'] = USER_AGENT;
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

  static String getRequestUrl(String endPoint) =>
      "$globalHOST/api/$apiVersion/$endPoint";

  static String baseUrl() => "$globalHOST/api/$apiVersion/";

  static Dio buildDio() {
    Dio dio = Dio();
    dio.options.baseUrl = baseUrl();
    dio.options.connectTimeout = 5000; //5s
    dio.options.receiveTimeout = 5000;
    dio.options.headers["Private-Token"] = globalTOKEN;
    dio.options.headers["User-Agent"] = USER_AGENT;
    dio.options.responseType = ResponseType.json;
    return dio;
  }
}
