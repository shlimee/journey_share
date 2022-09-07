import 'package:journey_share/presentation/bloc/state/states.dart';

import '../../../domain/entities/post.dart';

class PostState extends MyAppState {
  const PostState();
}

class EmptyState extends PostState {}

class LoadingState extends PostState {}

class LoadedState extends PostState {
  final List<Post> fetchedPosts;
  const LoadedState({required this.fetchedPosts});
}

class ErrorState extends PostState {
  final int? errorCode;
  final String? errorMessage;

  ErrorState({this.errorCode, this.errorMessage});
}
