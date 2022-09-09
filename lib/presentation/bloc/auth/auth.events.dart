import 'package:journey_share/presentation/bloc/events.dart';

class AuthEvent extends AppEvent {}

class OnLoginAttempt extends AuthEvent {
  final String userName;
  final String password;
  OnLoginAttempt({required this.userName, required this.password});
}

class OnRegisterAttempt extends AuthEvent {
  final String email;
  final String userName;
  final String password;
  OnRegisterAttempt({
    required this.email,
    required this.userName,
    required this.password,
  });
}
