import 'dart:io';

import 'package:journey_share/presentation/bloc/states.dart';

import '../../../domain/entities/post.dart';

class PostState extends MyAppState {
  const PostState();
}

class EmptyState extends PostState {}

class LoadingState extends PostState {}

class LoadedState extends PostState {
  final List<Post> fetchedPosts;
  const LoadedState({required this.fetchedPosts});

  @override
  List<Object?> get props => [fetchedPosts];
}

class LoadedUserPostsState extends PostState {
  final String userId;
  final List<Post> fetchedPosts;
  const LoadedUserPostsState(
      {required this.fetchedPosts, required this.userId});

  @override
  List<Object?> get props => [fetchedPosts];
}

class PostErrorState extends PostState {
  final int? errorCode;
  final String? errorMessage;

  PostErrorState({this.errorCode, this.errorMessage});
}

class CreateState extends PostState {
  final File? imageFile;

  CreateState({required this.imageFile});
}
