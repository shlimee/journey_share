import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:journey_share/core/error/failures.dart';
import 'package:journey_share/core/usecase.dart';
import 'package:journey_share/domain/repositories/user_repository.dart';

class Follow extends UseCase<bool, Params> {
  final UserRepository repository;

  Follow(this.repository);

  @override
  Future<Either<Failure, bool>> call(Params params) {
    // TODO: implement call
    return repository.follow(params.userId);
  }
}

class Params extends Equatable {
  final String userId;

  Params({required this.userId}) : super();

  @override
  List<Object?> get props => [userId];
}
