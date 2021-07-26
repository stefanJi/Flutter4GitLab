import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

const DEFAULT_API_VERSION = 'v4';
const USER_AGENT =
    "F4Lab Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.163 Safari/537.36";
const KEY_TOKEN = "private-token";
const KEY_USER_AGENT = "user-agent";

class GitlabClient extends http.BaseClient {
  static String globalHOST = "";
  static String globalTOKEN = "";
  static String apiVersion = "";

  final http.Client _inner = http.Client();

  static GitlabClient newInstance() => GitlabClient();

  static setUpTokenAndHost(String token, String host, String version) {
    globalTOKEN = token;
    globalHOST = host;
    apiVersion = version;
    authHeaders[KEY_TOKEN] = globalTOKEN;
  }

  Future<http.StreamedResponse> send(http.BaseRequest request) {
    authHeaders.forEach((k, v) => request.headers[k] = v);
    return _inner.send(request);
  }

  @override
  Future<http.Response> get(endPoint, {Map<String, String>? headers}) {
    return super.get(getRequestUrl(endPoint), headers: headers);
  }

  Future<http.Response> getRss(endPoint, {Map<String, String>? headers}) {
    return super.get(Uri.parse("$globalHOST/$endPoint"));
  }

  @override
  Future<http.Response> post(endPoint,
      {Map<String, String>? headers, body, Encoding? encoding}) {
    return super.post(getRequestUrl(endPoint),
        headers: headers, body: body, encoding: encoding);
  }

  @override
  Future<http.Response> put(url,
      {Map<String, String>? headers, body, Encoding? encoding}) {
    return super.put(getRequestUrl(url),
        headers: headers, body: body, encoding: encoding);
  }

  static Uri getRequestUrl(Uri endPoint) =>
      Uri.parse("$globalHOST/api/$apiVersion/${endPoint.path}");

  static String baseUrl() => "$globalHOST/api/$apiVersion/";

  static Dio buildDio() {
    Dio dio = Dio();
    dio.options.baseUrl = baseUrl();
    dio.options.connectTimeout = 5000; //5s
    dio.options.receiveTimeout = 5000;
    authHeaders.forEach((k, v) => dio.options.headers[k] = v);
    dio.options.responseType = ResponseType.json;
    return dio;
  }

  static Map<String, String> authHeaders = {
    KEY_TOKEN: globalTOKEN,
    KEY_USER_AGENT: USER_AGENT
  };
}
