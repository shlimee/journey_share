import 'package:dartz/dartz.dart';
import 'package:journey_share/core/error/failures.dart';
import 'package:journey_share/core/error/user_failures.dart';
import 'package:journey_share/data/datasources/user_remote_data_source.dart';
import 'package:journey_share/domain/entities/user.dart';
import 'package:journey_share/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, User>> getUser(String userId) async {
    try {
      final remoteTrivia = await remoteDataSource.getUser(userId);
      return Right(remoteTrivia);
    } catch (e) {
      return Left(UserFailure(message: e.toString()));
    }
  }
}
