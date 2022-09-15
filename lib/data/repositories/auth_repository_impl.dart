import 'package:dartz/dartz.dart';
import 'package:journey_share/core/error/auth_failures.dart';
import 'package:journey_share/core/error/failures.dart';
import 'package:journey_share/data/datasources/auth_remote_data_source.dart';
import 'package:journey_share/domain/entities/user.dart';
import 'package:journey_share/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, User>> login(String email, String password) async {
    try {
      final remoteTrivia = await remoteDataSource.login(email, password);
      return Right(remoteTrivia);
    } catch (e) {
      return Left(AuthServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> logout() async {
    try {
      final remote = await remoteDataSource.logout();
      return Right(remote);
    } catch (e) {
      return Left(AuthServerFailure(message: e.toString()));
    }
  }
}
