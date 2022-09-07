import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:journey_share/core/error/failures.dart';
import 'package:journey_share/core/usecase.dart';
import 'package:journey_share/domain/entities/post.dart';
import 'package:journey_share/domain/entities/token_entity.dart';
import 'package:journey_share/domain/entities/user.dart';
import 'package:journey_share/domain/repositories/auth_repository.dart';
import 'package:journey_share/domain/repositories/post_repository.dart';
import 'package:journey_share/domain/repositories/user_repository.dart';

class GetPosts extends UseCase<List<Post>, NoParams> {
  final PostRepository repository;

  GetPosts(this.repository);

  Future<Either<Failure, List<Post>>> execute() async {
    return await repository.getPosts();
  }

  @override
  Future<Either<Failure, List<Post>>> call(NoParams params) {
    return repository.getPosts();
  }
}
