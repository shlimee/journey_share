import 'package:journey_share/data/models/post_model.dart';
import 'package:journey_share/data/models/user_model.dart';
import 'package:journey_share/domain/entities/post.dart';
import 'package:journey_share/domain/entities/search.dart';

import '../../domain/entities/user.dart';

class SearchResultModel extends SearchResult {
  const SearchResultModel(
      {required List<User> users, required List<Post> posts})
      : super(users: users, posts: posts);

  factory SearchResultModel.fromJson(Map<String, dynamic> json) {
    return SearchResultModel(
      users: (json['users'] as List<Map<String, dynamic>>)
          .map((e) => UserModel.fromJson(e))
          .toList(),
      posts: (json['posts'] as List<Map<String, dynamic>>)
          .map((e) => PostModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'users': users,
      'posts': posts,
    };
  }
}
