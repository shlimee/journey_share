import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:journey_share/core/error/failures.dart';
import 'package:journey_share/domain/entities/search.dart';

import '../../core/usecase.dart';

class Search extends UseCase<SearchResult, Params> {
  final PostRepository repository;

  Publish(this.repository);

  @override
  Future<Either<Failure, SearchResult>> call(Params params) {
    // TODO: implement call
    return repository.publish(params.file, params.description);
  }
}

class Params extends Equatable {
  final File file;
  final String description;

  Params({required this.file, required this.description}) : super();

  @override
  List<Object?> get props => [file, description];
}
