import 'package:journey_share/presentation/bloc/events.dart';

class UserEvent extends AppEvent {}

class FetchUser extends UserEvent {
  final String userId;

  FetchUser({required this.userId});
}
