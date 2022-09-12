import 'package:journey_share/data/models/user_model.dart';
import 'package:journey_share/domain/entities/post.dart';
import 'package:journey_share/domain/entities/token_entity.dart';
import 'package:journey_share/domain/entities/user.dart';

class PostModel extends Post {
  PostModel(
      {required UserModel user,
      required String url,
      required String description,
      required bool isActive})
      : super(
            user: user, description: description, isActive: isActive, url: url);

  factory PostModel.fromJson(Map<String, dynamic> json) {
    print("json? " + json.toString());
    return PostModel(
      user: UserModel.fromJson(json['user']),
      url: json['url'],
      description: json['description'],
      isActive: json['isActive'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user,
      'url': url,
      'description': description,
      'isActive': isActive,
    };
  }
}
