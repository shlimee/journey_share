import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:journey_share/core/error/failures.dart';
import 'package:journey_share/core/error/post_failures.dart';
import 'package:journey_share/core/error/search_failures.dart';
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

  @override
  Future<Either<Failure, Post>> publish(File file, String description) async {
    try {
      final response = await remoteDataSource.publish(file, description);
      return Right(response);
    } catch (e) {
      return Left(PostFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Post>>> getUserPosts(String userId) async {
    try {
      final response = await remoteDataSource.getUserPosts(userId);
      return Right(response);
    } catch (e) {
      return Left(PostFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Post>>> search(String searchText) async {
    try {
      final remote = await remoteDataSource.search(searchText);
      return Right(remote);
    } catch (e) {
      return Left(SearchFailure(message: e.toString()));
    }
  }
}
