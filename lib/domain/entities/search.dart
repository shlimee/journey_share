import 'package:equatable/equatable.dart';
import 'package:journey_share/domain/entities/base_entity.dart';
import 'package:journey_share/domain/entities/post.dart';
import 'package:journey_share/domain/entities/user.dart';

class SearchResult extends Equatable {
  final List<User> users;
  final List<Post> posts;

  const SearchResult({
    required this.users,
    required this.posts,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [users, posts];
}
