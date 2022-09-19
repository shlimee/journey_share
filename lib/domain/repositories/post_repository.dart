import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:journey_share/core/error/failures.dart';
import 'package:journey_share/domain/entities/post.dart';

abstract class PostRepository {
  Future<Either<Failure, List<Post>>>
      getPosts(); // TODO: make sure to use some filtering alhorithm
  Future<Either<Failure, Post>> publish(File file, String description);
  Future<Either<Failure, List<Post>>> getUserPosts(String userId);
  Future<Either<Failure, List<Post>>> search(String searchText);
}
