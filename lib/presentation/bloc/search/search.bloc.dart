import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:journey_share/presentation/bloc/search/search.events.dart';
import 'package:journey_share/presentation/bloc/search/search.states.dart';

import '../../../domain/usecases/search.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final Search search;
  SearchState get initialState => EmptyState();

  SearchBloc({
    required this.search,
  }) : super(EmptyState()) {
    on<OnSearchFieldChanged>(
      (event, emit) async {
        final searchResult =
            await search.call(Params(searchText: event.searchText));

        searchResult.fold(
          (failure) {
            print(failure.message);
            emit(SearchErrorState(
                errorCode: 414, errorMessage: failure.message.toString()));
          },
          (result) {
            emit(SearchedState(posts: result.posts, users: result.users));
          },
        );
      },
    );
  }
}
