import 'package:dartz/dartz.dart';
import 'package:journey_share/core/error/failures.dart';
import 'package:journey_share/domain/entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> login(String email, String password);

  Future<Either<Failure, bool>> logout();
}
