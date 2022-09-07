import 'package:dartz/dartz.dart';
import 'package:journey_share/core/error/failures.dart';
import 'package:journey_share/domain/entities/token_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, Token>> login(String email, String password);
}
