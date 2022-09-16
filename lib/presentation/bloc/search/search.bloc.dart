import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:journey_share/presentation/bloc/search/search.events.dart';
import 'package:journey_share/presentation/bloc/search/search.states.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchState get initialState => EmptyState();

  SearchBloc() : super(EmptyState()) {
    on<OnSearchFieldChanged>(
      (event, emit) {},
    );
  }
}
