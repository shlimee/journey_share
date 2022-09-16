import 'package:journey_share/domain/entities/post.dart';
import 'package:journey_share/domain/entities/user.dart';
import 'package:journey_share/presentation/bloc/states.dart';

class SearchState extends MyAppState {
  const SearchState();
}

class EmptyState extends SearchState {}

class SearchedState extends SearchState {
  final List<User> users;
  final List<Post> posts;

  const SearchedState({required this.users, required this.posts});

  @override
  List<Object?> get props => [users, posts];
}

class SearchErrorState extends SearchState {}
