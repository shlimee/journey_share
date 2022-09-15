import 'dart:convert';

import 'package:journey_share/data/api.dart';
import 'package:journey_share/data/models/auth_model.dart';
import 'package:journey_share/data/models/user_model.dart';
import 'package:journey_share/domain/entities/token_entity.dart';
import 'package:journey_share/domain/entities/user.dart';

import '../user_secure_storage.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String userName, String password);
  Future<User> parseToken(Token token);

  Future<bool> logout();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final String apiUrl;
  final Api api;
  AuthRemoteDataSourceImpl({
    required this.apiUrl,
  }) : api = Api(apiUrl: apiUrl);

  @override
  Future<UserModel> login(String userName, String password) async {
    // TODO: implement login
    final response = await api.post(
      endpoint: "auth/login",
      body: {'userName': userName, 'password': password},
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      final tokenModel = TokenModel.fromJson(json.decode(response.body));
      await UserSecureStorage.setValue('token', tokenModel.accessToken);
      final user = await parseToken(tokenModel);
      return user;
    } else {
      final error = jsonDecode(response.body);
      throw Exception(error["message"].toString());
    }
  }

  @override
  Future<UserModel> parseToken(Token token) async {
    final _token = await UserSecureStorage.getValue('token');

    final response = await api.get(endpoint: 'user/me', accessToken: _token);

    final userModel = UserModel.fromJson(json.decode(response.body));
    return userModel;
  }

  @override
  Future<bool> logout() async {
    final _token = await UserSecureStorage.getValue('token');
    if (_token == null) return false;

    await UserSecureStorage.setValue('token', '');

    return true;
  }
}
