import 'package:journey_share/data/models/user_model.dart';
import 'package:journey_share/domain/entities/post.dart';

class PostModel extends Post {
  PostModel(
      {required UserModel user,
      required String url,
      required String description,
      required bool isPrivate})
      : super(
            user: user,
            description: description,
            isPrivate: isPrivate,
            url: url);

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      user: UserModel.fromJson(json['user']),
      url: json['url'],
      description: json['description'],
      isPrivate: json['isPrivate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user,
      'url': url,
      'description': description,
      'isPrivate': isPrivate,
    };
  }
}
