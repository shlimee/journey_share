import 'package:dartz/dartz.dart';
import 'package:journey_share/core/error/failures.dart';
import 'package:journey_share/domain/entities/post.dart';

abstract class PostRepository {
  Future<Either<Failure, List<Post>>>
      getPosts(); // TODO: make sure to use some filtering alhorithm
}
