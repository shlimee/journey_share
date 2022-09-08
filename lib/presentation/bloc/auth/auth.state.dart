import 'package:journey_share/domain/entities/token_entity.dart';
import 'package:journey_share/presentation/bloc/states.dart';

class AuthState extends MyAppState {
  const AuthState();
}

class EmptyState extends AuthState {}

class AuthenticatedState extends AuthState {
  //final Token token;
  final DecryptedToken token;

  const AuthenticatedState({required this.token});
}

class LoadingState extends AuthState {}

class NonAuthenticatedState extends AuthState {}

class ErrorState extends AuthState {
  final int? errorCode;
  final String? errorMessage;

  ErrorState({this.errorCode, this.errorMessage});
}
