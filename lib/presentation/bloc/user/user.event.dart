import 'package:journey_share/presentation/bloc/events.dart';

class UserEvent extends AppEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class FetchUser extends UserEvent {
  final String userId;

  FetchUser({required this.userId});

  @override
  // TODO: implement props
  List<Object?> get props => [userId];
}
