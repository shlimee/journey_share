import 'package:equatable/equatable.dart';
import 'package:journey_share/domain/entities/base_entity.dart';
import 'package:journey_share/domain/entities/user.dart';

class Post extends Equatable with BaseEntity {
  final String url;
  final User user;
  final String description;
  final bool isPrivate;

  Post(
      {required this.url,
      required this.user,
      required this.description,
      required this.isPrivate});

  @override
  // TODO: implement props
  List<Object?> get props => [url, user, description, isPrivate];
}
