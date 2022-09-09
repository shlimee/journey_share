import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:journey_share/data/api.dart';
import 'package:journey_share/data/models/auth_model.dart';
import 'package:journey_share/data/models/post_model.dart';
import 'package:journey_share/domain/entities/post.dart';
import 'package:journey_share/domain/entities/token_entity.dart';
import 'package:http/http.dart' as http;

abstract class PostRemoteDataSource {
  Future<List<Post>> getAll();
}

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  final Api api;
  final String apiUrl;

  PostRemoteDataSourceImpl({required this.apiUrl}) : api = Api(apiUrl: apiUrl);

  @override
  Future<List<Post>> getAll() async {
    //final response = await client.get(Uri.http("localhost:3333", "api/post"));
    final response =
        await (Api(apiUrl: "http://localhost:3333/").get(endpoint: "api/post"));

    var responseBodyArray = json.decode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      var mappedResponse = responseBodyArray.map<PostModel>((e) {
        return PostModel.fromJson(e);
      }).toList();
      return mappedResponse as List<Post>;
    } else {
      final error = jsonDecode(response.body);
      throw Exception(error["message"].toString());
    }
  }
}
