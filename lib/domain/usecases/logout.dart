import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:journey_share/core/error/failures.dart';
import 'package:journey_share/core/usecase.dart';
import 'package:journey_share/domain/entities/token_entity.dart';
import 'package:journey_share/domain/entities/user.dart';
import 'package:journey_share/domain/repositories/auth_repository.dart';
import 'package:journey_share/domain/repositories/user_repository.dart';

class Logout extends UseCase<bool, NoParams> {
  final AuthRepository repository;

  Logout(this.repository);

  Future<Either<Failure, bool>> execute({
    required String email,
    required String password,
  }) async {
    return await repository.logout();
  }

  @override
  Future<Either<Failure, bool>> call(NoParams params) {
    return repository.logout();
  }
}
