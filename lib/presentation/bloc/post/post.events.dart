import 'dart:io';

import 'package:journey_share/presentation/bloc/events.dart';

class PostEvent extends AppEvent {}

class OnLoadingAllPosts extends PostEvent {}

class OnLoadingUserPosts extends PostEvent {
  final String userId;

  OnLoadingUserPosts(this.userId);
}

class OnLoaded extends PostEvent {}

class OnCreate extends PostEvent {
  final File fileToUpload;

  OnCreate({required this.fileToUpload});
}

class OnPublish extends PostEvent {
  final File fileToPublish;
  final String description;

  OnPublish({required this.fileToPublish, required this.description});
}
