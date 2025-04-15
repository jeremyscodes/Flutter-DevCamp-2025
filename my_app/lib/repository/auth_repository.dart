import 'package:my_app/Services/login_service.dart';

class AuthRepository {
  final AuthService _authService;

  AuthRepository(this._authService);

  Future<String?> login(String email, String password) async {
    return _authService.login(email: email, password: password);
  }
}