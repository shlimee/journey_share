import 'package:equatable/equatable.dart';
import 'package:jwt_decode/jwt_decode.dart';

class Token extends Equatable {
  String accessToken;

  Token({required this.accessToken}) {}

  @override
  // TODO: implement props
  List<Object?> get props => [accessToken];
}

class DecryptedToken extends Equatable {
  Map<String, dynamic> decryptedObject;

  DecryptedToken({required this.decryptedObject});

  static DecryptedToken decryptToken(Token token) {
    Map<String, dynamic> parsed = Jwt.parseJwt(token.accessToken);

    return DecryptedToken(decryptedObject: parsed);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [decryptedObject];
}
