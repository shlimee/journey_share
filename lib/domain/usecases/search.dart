import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:journey_share/core/error/failures.dart';
import 'package:journey_share/core/error/search_failures.dart';
import 'package:journey_share/domain/entities/search.dart';
import 'package:journey_share/domain/repositories/post_repository.dart';
import 'package:journey_share/domain/repositories/user_repository.dart';

import '../../core/usecase.dart';

class Search extends UseCase<SearchResult, Params> {
  final PostRepository postRepository;
  final UserRepository userRepository;

  Search(this.postRepository, this.userRepository);

  @override
  Future<Either<Failure, SearchResult>> call(Params params) async {
    final foundPostsEither = await postRepository.search(params.searchText);
    final foundUsersEither = await userRepository.search(params.searchText);

    var foundPosts;
    var foundUsers;

    foundPostsEither.fold((l) => null, (r) {
      foundPosts = r;
    });
    foundUsersEither.fold((l) => null, (r) {
      foundUsers = r;
    });

    print(foundUsers);

    if (foundPosts != null || foundUsers != null) {
      return Right(SearchResult(posts: foundPosts, users: foundUsers));
    } else {
      return const Left(SearchFailure(message: 'Search Failure!'));
    }
  }
}

class Params extends Equatable {
  final String searchText;

  Params({
    required this.searchText,
  }) : super();

  @override
  List<Object?> get props => [searchText];
}
