import 'dart:io';

import 'package:journey_share/presentation/bloc/events.dart';

class PostEvent extends AppEvent {}

class OnLoadingPosts extends PostEvent {}

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
