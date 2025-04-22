import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart';
import 'package:my_app/repository/auth_repository.dart';
import 'package:my_app/screens/login/bloc/login_state.dart';

part 'login_event.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;

  LoginBloc({required this.authRepository}) : super(LoginInitial()) {
    on<EmailChanged>(updateEmail);
    on<PasswordChanged>(updatePassword);
    on<LoginSubmitted>(loginSubmitted);
  }

  void updateEmail(event, emit) {
    String email = event.email;
    if (email.contains('@') && email.contains('.')) {
      emit(state.copyWith(
        email: event.email,
        isButtonEnabled: state.password.isNotEmpty,
        status: FormzStatus.valid
      ));
    } else {
      emit(state.copyWith(status: FormzStatus.invalid));
    }
  }

  void updatePassword(event, emit) {
    emit(state.copyWith(
      password: event.password,
      isButtonEnabled: event.password.isNotEmpty && state.email.isNotEmpty,
    ));
    log('Password changed');
    log('Password: ${event.password}');
    log('Email: ${state.email}');
    log('button enabled: ${state.isButtonEnabled}');
  }

  Future<void> loginSubmitted(event, emit) async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    log('Login submitted');
    log('Email: ${state.email}');
    log('Password: ${state.password}');

    try {
      print("fetching token");
      final token = await authRepository.login(state.email, state.password);
      //TODO: check that token has not expired
      if (token != null) {
        log('login successful');
        print(token);
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } else {
        log('login failed');
        emit(state.copyWith(
          status: FormzStatus.submissionFailure,
          errorMessage: 'Invalid email or password',
        ));
      }
    } catch (e) {
      log('login failed');
      emit(state.copyWith(
          status: FormzStatus.submissionFailure,
          errorMessage: 'Login failed. Please try again.'));
    }
  }
}
