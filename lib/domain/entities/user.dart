import 'package:equatable/equatable.dart';
import 'package:journey_share/domain/entities/base_entity.dart';
import 'package:journey_share/domain/entities/post.dart';

class User extends Equatable with BaseEntity {
  final String id;
  final String userName;
  final String email;
  final String password;
  final bool isActive;

  User({
    required this.id,
    required this.userName,
    required this.email,
    required this.password,
    required this.isActive,
  }) : super();

  @override
  List<Object?> get props => [id, userName, email, password, isActive];
}
