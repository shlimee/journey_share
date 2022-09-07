import 'package:dartz/dartz.dart';
import 'package:journey_share/core/error/failures.dart';
import 'package:journey_share/core/error/post_failures.dart';
import 'package:journey_share/data/datasources/post_remote_data_source.dart';
import 'package:journey_share/domain/entities/post.dart';
import 'package:journey_share/domain/repositories/post_repository.dart';

class PostRepositoryImpl implements PostRepository {
  final PostRemoteDataSource remoteDataSource;

  PostRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Post>>> getPosts() async {
    try {
      final remoteTrivia = await remoteDataSource.getAll();
      return Right(remoteTrivia);
    } catch (e) {
      return Left(PostFailure(message: e.toString()));
    }
  }
}
