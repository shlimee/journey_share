import 'package:journey_share/domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required String id,
    required String email,
    required String userName,
    required String password,
    required bool isActive,
  }) : super(
          id: id,
          email: email,
          userName: userName,
          password: password,
          isActive: isActive,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      userName: json['userName'],
      email: json['email'],
      password: json['password'],
      isActive: json['isActive'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userName': userName,
      'email': email,
      'password': password,
      'isActive': isActive,
    };
  }
}
