import 'package:journey_share/domain/entities/token_entity.dart';
import 'package:journey_share/domain/entities/user.dart';

class TokenModel extends Token {
  TokenModel({required String accessToken}) : super(accessToken: accessToken);

  factory TokenModel.fromJson(Map<String, dynamic> json) {
    return TokenModel(
      accessToken: json['access_token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
    };
  }
}
