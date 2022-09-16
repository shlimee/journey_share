import 'dart:convert';
import 'dart:io';

import 'package:journey_share/data/api.dart';
import 'package:journey_share/data/models/post_model.dart';
import 'package:journey_share/domain/entities/post.dart';

abstract class PostRemoteDataSource {
  Future<List<Post>> getAll();
  Future<Post> publish(File file, String description);
  Future<List<Post>> getUserPosts(String userId);
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

  @override
  Future<Post> publish(File file, String description) async {
    final body = {'description': description};
    final response = await (Api(apiUrl: "http://localhost:3333/")
        .postWithFile(endpoint: "api/post", body: body, file: file));
    if (response.statusCode == 200 || response.statusCode == 201) {
      return PostModel.fromJson(json.decode(response.body));
    } else {
      final error = jsonDecode(response.body);
      throw Exception(error["message"].toString());
    }
  }

  @override
  Future<List<Post>> getUserPosts(String userId) async {
    final response = await (Api(apiUrl: "http://localhost:3333/")
        .get(endpoint: "api/post/user/" + userId));

    var responseBodyArray = json.decode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      var mappedResponse = responseBodyArray.map<PostModel>((e) {
        print(e);
        return PostModel.fromJson(e);
      }).toList();
      return mappedResponse as List<Post>;
    } else {
      final error = jsonDecode(response.body);
      throw Exception(error["message"].toString());
    }
  }
}
