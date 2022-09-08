import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:journey_share/domain/entities/token_entity.dart';
import 'dart:async';

import 'package:journey_share/presentation/bloc/auth/auth.events.dart';
import 'package:journey_share/presentation/bloc/auth/auth.state.dart';
import 'package:meta/meta.dart';

import '../../domain/usecases/login.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Login login;

  @override
  AuthState get initialState => NonAuthenticatedState();

  AuthBloc({required this.login}) : super(NonAuthenticatedState()) {
    on<OnLoginAttempt>((event, emit) async {
      await _onLogin(event, emit);
    });
    on<AuthEvent>((event, emit) {});
    on<OnLoginFailed>((event, emit) {});
    on<OnLoginSuccess>((event, emit) {});
    on<OnRegisterAttempt>((event, emit) async {});
    on<OnRegisterFailed>((event, emit) {});
    on<OnRegisterSuccess>((event, emit) {});
  }

  _onLogin(dynamic event, Emitter emit) async {
    final loginResult = await login
        .call(Params(userName: event.userName, password: event.password));
    loginResult.fold(
      (failure) {
        emit(ErrorState(
            errorCode: 414, errorMessage: failure.message.toString()));
      },
      (token) {
        print("successfully logged in: " + token.toString());
        var decoded = DecryptedToken.decryptToken(token);
        emit(AuthenticatedState(token: decoded));
      },
    );
  }
}
