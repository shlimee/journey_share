import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:journey_share/core/error/failures.dart';
import 'package:journey_share/core/usecase.dart';
import 'package:journey_share/domain/entities/user.dart';
import 'package:journey_share/domain/repositories/user_repository.dart';

class GetUser extends UseCase<User, GetUserParams> {
  final UserRepository repository;

  GetUser(this.repository);

  @override
  Future<Either<Failure, User>> call(GetUserParams params) {
    return repository.getUser(params.userId);
  }
}

class GetUserParams extends Equatable {
  final String userId;

  const GetUserParams({required this.userId}) : super();

  @override
  List<Object?> get props => [userId];
}
