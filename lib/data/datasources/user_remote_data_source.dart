import 'dart:convert';

import 'package:journey_share/data/api.dart';
import 'package:journey_share/domain/entities/user.dart';

import '../models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<User> getUser(String userId);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final String apiUrl;
  final Api api;
  UserRemoteDataSourceImpl({
    required this.apiUrl,
  }) : api = Api(apiUrl: apiUrl);

  @override
  Future<UserModel> getUser(String userId) async {
    final response = await api.get(
      endpoint: "user/",
      queryParameters: {
        'userId': userId,
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      final error = jsonDecode(response.body);
      throw Exception(error["message"].toString());
    }
  }
}
