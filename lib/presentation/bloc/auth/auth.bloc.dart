import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:journey_share/core/usecase.dart';
import 'package:journey_share/domain/entities/token_entity.dart';
import 'package:journey_share/domain/usecases/logout.dart';
import 'dart:async';

import 'package:journey_share/presentation/bloc/auth/auth.events.dart';
import 'package:journey_share/presentation/bloc/auth/auth.state.dart';
import 'package:meta/meta.dart';

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
        emit(ErrorState(
            errorCode: 414, errorMessage: failure.message.toString()));
      },
      (user) {
        print("successfully logged in: " + user.toString());
        emit(AuthenticatedState(user: user));
      },
    );
  }

  _onLogout(OnLogoutAttempt event, Emitter<AuthState> emit) async {
    final logoutResult = await logout.call(NoParams());

    logoutResult.fold(
      (failure) {
        emit(ErrorState(
            errorCode: 414, errorMessage: failure.message.toString()));
      },
      (res) {
        print("successfully logged out: " + res.toString());
        emit(NonAuthenticatedState());
      },
    );
  }
}
