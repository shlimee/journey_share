import 'package:journey_share/presentation/bloc/events.dart';

class AuthEvent extends AppEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class OnLoginAttempt extends AuthEvent {
  final String userName;
  final String password;
  OnLoginAttempt({required this.userName, required this.password});

  @override
  // TODO: implement props
  List<Object?> get props => [userName, password];
}

class OnLogoutAttempt extends AuthEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
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

  @override
  // TODO: implement props
  List<Object?> get props => [email, userName, password];
}
