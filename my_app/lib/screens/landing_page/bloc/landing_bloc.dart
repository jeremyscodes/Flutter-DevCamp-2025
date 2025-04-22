import 'package:bloc/bloc.dart';
import 'package:my_app/repository/auth_repository.dart';

part 'landing_event.dart';

part 'landing_state.dart';

class LandingBloc extends Bloc<LandingEvent, LandingState> {
  final AuthRepository authRepository;

  LandingBloc({required this.authRepository}) : super(LandingInitial()) {
    on<GetAndValidateToken>((event, emit) async {
      print('in landing bloc');
      final token = await authRepository.getToken();
      if (token != null) {
        print('token found');
        bool isValid = await authRepository.validate(token: token);
        print('toke valid $isValid');
        emit(TokenValidated(validToken: isValid));
      }
    });
  }
}
