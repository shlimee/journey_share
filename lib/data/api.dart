import 'dart:convert';
import 'dart:io';
import 'package:http_parser/http_parser.dart';

import 'package:http/http.dart' as http;
import 'package:path/path.dart';

import 'api_exceptions.dart';

void checkError(http.Response response) {
  if ([200, 201, 204].any((code) => code == response.statusCode)) {
    return;
  }

  String errorStr = 'undefinedError';
  try {
    final decoded = jsonDecode(response.body);
    if (decoded['code'] != null) {
      errorStr = decoded['code'];
      if (decoded['code'] != null) {
        final msg = decoded['code'];
        if (msg is String) {
          errorStr = msg;
        } else if (msg is List) {
          errorStr = msg.join('\n');
        } else if (msg is Map) {
          errorStr =
              msg.entries.map((rec) => rec.key + ': ' + rec.value).join('\n');
        }
      }
    }
  } catch (_) {}

  switch (response.statusCode) {
    case 400:
      throw BadRequestException(
          statusCode: response.statusCode, message: errorStr);
    case 401:
      throw UnauthorizedException(
          statusCode: response.statusCode, message: errorStr);
    case 403:
      throw ForbiddenException(
          statusCode: response.statusCode, message: errorStr);
    case 501:
      throw NotImplementedException(
          statusCode: response.statusCode, message: errorStr);
    default:
      throw UnkownException(statusCode: response.statusCode, message: errorStr);
  }
}

class Api {
  final String apiUrl;

  Api({required this.apiUrl});

  Uri assembleUri(String endpoint, [Map<String, dynamic>? queryParameters]) {
    return Uri.parse(apiUrl + endpoint)
        .resolveUri(Uri(queryParameters: queryParameters));
  }

  Future<http.Response> post(
      {required String endpoint,
      Map<String, dynamic>? body,
      Map<String, dynamic>? queryParameters}) {
    final requestUrl = assembleUri(endpoint, queryParameters);

    final token =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyTmFtZSI6InRlc3RfdXNlcl8xMjMiLCJpZCI6IjEiLCJlbWFpbCI6ImFzZCIsImlhdCI6MTY2Mjk5MTIxNSwiZXhwIjoxNjYyOTkxMjc1fQ.qhZEsSa6hVwrLXCjWtIVHqjrTNt57iD_QCdceFjKkUM';

    return http.post(
      requestUrl,
      body: jsonEncode(body),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${token}'
      },
    );
  }

  Future<http.Response> postWithFile(
      {required String endpoint,
      required File file,
      Map<String, String>? body,
      Map<String, dynamic>? queryParameters}) async {
    final requestUrl = assembleUri(endpoint, queryParameters);

    final token =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyTmFtZSI6InRlc3RfdXNlcl8xMjMiLCJpZCI6IjEiLCJlbWFpbCI6ImFzZCIsImlhdCI6MTY2Mjk5MTIxNSwiZXhwIjoxNjYyOTkxMjc1fQ.qhZEsSa6hVwrLXCjWtIVHqjrTNt57iD_QCdceFjKkUM';

    final request = http.MultipartRequest("POST", requestUrl);
    if (body != null) request.fields.addAll(body);
    request.headers.addAll({'Authorization': 'Bearer ${token}'});
    request.files.add(await http.MultipartFile.fromPath('file', file.path,
        filename: basename(file.path)));
    final res = await request.send();
    return http.Response.fromStream(res);
  }

  Future<http.Response> get(
      {required String endpoint, Map<String, dynamic>? queryParameters}) {
    final requestUrl = assembleUri(endpoint, queryParameters);

    return http.get(
      requestUrl,
      headers: {
        'Content-Type': 'application/json',
      },
    );
  }

  //Future<http.Response> put() {}
  //Future<http.Response> patch() {}
  //Future<http.Response> delete() {}
}
