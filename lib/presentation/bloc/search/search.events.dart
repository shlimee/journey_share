import 'package:journey_share/presentation/bloc/events.dart';

class SearchEvent extends AppEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class OnSearchFieldChanged extends SearchEvent {
  final String searchText;

  OnSearchFieldChanged({required this.searchText});

  @override
  // TODO: implement props
  List<Object?> get props => [searchText];
}
