import 'package:formz/formz.dart';

class LoginState {
  final String email;
  final String password;
  final FormzStatus status; // valid/invalid/submission in progress
  final String? errorMessage;
  final bool isButtonEnabled;

  LoginState({
    this.email='',
    this.password='',
    this.status= FormzStatus.pure,
    this.errorMessage,
    this.isButtonEnabled=false
  });

  LoginState copyWith({
    String? email,
    String? password,
    FormzStatus? status,
    String? errorMessage,
    bool? isButtonEnabled,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      errorMessage: errorMessage,
      isButtonEnabled: isButtonEnabled ?? this.isButtonEnabled,
    );
  }
}

final class LoginInitial extends LoginState {}

