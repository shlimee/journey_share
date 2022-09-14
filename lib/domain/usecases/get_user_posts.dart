import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:journey_share/core/error/failures.dart';
import 'package:journey_share/core/usecase.dart';
import 'package:journey_share/domain/entities/post.dart';
import 'package:journey_share/domain/repositories/post_repository.dart';

class GetUserPosts extends UseCase<List<Post>, GetUserPostsParams> {
  final PostRepository repository;

  GetUserPosts(this.repository);

  Future<Either<Failure, List<Post>>> execute(GetUserPostsParams params) async {
    return await repository.getUserPosts(params.userId);
  }

  @override
  Future<Either<Failure, List<Post>>> call(GetUserPostsParams params) {
    return repository.getUserPosts(params.userId);
  }
}

class GetUserPostsParams extends Equatable {
  final String userId;

  GetUserPostsParams({required this.userId}) : super();

  @override
  List<Object?> get props => [userId];
}
