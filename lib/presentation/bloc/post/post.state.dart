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

class ErrorState extends PostState {
  final int? errorCode;
  final String? errorMessage;

  ErrorState({this.errorCode, this.errorMessage});
}

class CreateState extends PostState {
  final File? imageFile;

  CreateState({required this.imageFile});
}
