import 'dart:convert';

import 'package:http/http.dart' as http;

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

class Api {}
