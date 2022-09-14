import 'package:dartz/dartz.dart';
import 'package:journey_share/core/error/failures.dart';
import 'package:journey_share/domain/entities/user.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> getUser(String userId);
}
