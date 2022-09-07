import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:journey_share/data/models/auth_model.dart';
import 'package:journey_share/domain/entities/token_entity.dart';
import 'package:http/http.dart' as http;

abstract class AuthRemoteDataSource {
  Future<Token> login(String userName, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;

  AuthRemoteDataSourceImpl({required this.client});

  @override
  Future<Token> login(String userName, String password) async {
    // TODO: implement login
    final response = await client.post(
      Uri.http("localhost:3333", "api/auth/login"),
      body: json.encode({'userName': userName, 'password': password}),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return TokenModel.fromJson(json.decode(response.body));
    } else {
      final error = jsonDecode(response.body);
      throw Exception(error["message"].toString());
    }
  }
}
