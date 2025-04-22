part of 'landing_bloc.dart';

sealed class LandingEvent {}

class GetAndValidateToken extends LandingEvent {

  GetAndValidateToken();
}

