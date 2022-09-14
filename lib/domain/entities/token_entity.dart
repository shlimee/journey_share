import 'package:equatable/equatable.dart';
import 'package:jwt_decode/jwt_decode.dart';

class Token extends Equatable {
  String accessToken;

  Token({required this.accessToken}) {}

  @override
  // TODO: implement props
  List<Object?> get props => [accessToken];
}
