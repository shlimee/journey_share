import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:journey_share/core/error/failures.dart';
import 'package:journey_share/core/usecase.dart';
import 'package:journey_share/domain/entities/token_entity.dart';
import 'package:journey_share/domain/entities/user.dart';
import 'package:journey_share/domain/repositories/auth_repository.dart';
import 'package:journey_share/domain/repositories/user_repository.dart';

class Login extends UseCase<Token, Params> {
  final AuthRepository repository;

  Login(this.repository);

  Future<Either<Failure, Token>> execute({
    required String email,
    required String password,
  }) async {
    return await repository.login(email, password);
  }

  @override
  Future<Either<Failure, Token>> call(Params params) {
    return repository.login(params.userName, params.password);
  }
}

class Params extends Equatable {
  final String userName;
  final String password;

  Params({required this.userName, required this.password}) : super();

  @override
  List<Object?> get props => [userName, password];
}
