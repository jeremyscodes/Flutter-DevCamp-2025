part of 'landing_bloc.dart';

sealed class LandingState {
  final bool validToken;

  const LandingState({this.validToken=false});
}

final class LandingInitial extends LandingState {
  const LandingInitial() : super(validToken: false);
}

final class TokenValidated extends LandingState {
  const TokenValidated({required super.validToken});
}


// states:

// token valid -> product page , else -> login page
//