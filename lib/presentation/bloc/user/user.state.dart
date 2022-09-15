import 'package:journey_share/domain/entities/user.dart';
import 'package:journey_share/presentation/bloc/states.dart';

class UserState extends MyAppState {
  const UserState();
}

class EmptyUserState extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final User user;

  const UserLoaded({required this.user});
}

class UserError extends UserState {
  final int errorCode;
  final String errorMessage;

  const UserError({required this.errorCode, required this.errorMessage});
}
