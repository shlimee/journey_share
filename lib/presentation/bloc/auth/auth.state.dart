import 'package:journey_share/presentation/bloc/states.dart';

import '../../../domain/entities/user.dart';

class AuthState extends MyAppState {
  const AuthState();
}

class AuthenticatedState extends AuthState {
  final User user;

  const AuthenticatedState({required this.user});
}

class LoadingState extends AuthState {}

class NonAuthenticatedState extends AuthState {}

class AuthErrorState extends AuthState {
  final int? errorCode;
  final String? errorMessage;

  AuthErrorState({this.errorCode, this.errorMessage});
}
