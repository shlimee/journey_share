import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:journey_share/core/usecase.dart';
import 'package:journey_share/domain/usecases/logout.dart';
import 'package:journey_share/presentation/bloc/auth/auth.events.dart';
import 'package:journey_share/presentation/bloc/auth/auth.state.dart';

import '../../../domain/usecases/login.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Login login;
  final Logout logout;

  @override
  AuthState get initialState => NonAuthenticatedState();

  AuthBloc({required this.login, required this.logout})
      : super(NonAuthenticatedState()) {
    on<OnLoginAttempt>((event, emit) async {
      await _onLogin(event, emit);
    });
    on<OnLogoutAttempt>((event, emit) async {
      await _onLogout(event, emit);
    });
    on<OnRegisterAttempt>((event, emit) async {});
  }

  _onLogin(dynamic event, Emitter emit) async {
    final loginResult = await login
        .call(Params(userName: event.userName, password: event.password));
    loginResult.fold(
      (failure) {
        emit(AuthErrorState(
            errorCode: 414, errorMessage: failure.message.toString()));
      },
      (user) {
        emit(AuthenticatedState(user: user));
      },
    );
  }

  _onLogout(OnLogoutAttempt event, Emitter<AuthState> emit) async {
    final logoutResult = await logout.call(NoParams());

    logoutResult.fold(
      (failure) {
        emit(AuthErrorState(
            errorCode: 414, errorMessage: failure.message.toString()));
      },
      (res) {
        emit(NonAuthenticatedState());
      },
    );
  }
}
