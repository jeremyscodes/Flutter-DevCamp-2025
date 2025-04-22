import 'package:my_app/Services/login_service.dart';
import 'package:my_app/storage/secure_storage.dart';

class AuthRepository {
  final AuthService _authService;
  final SecureStorageService _storageService;

  AuthRepository(this._authService, this._storageService);

  Future<String?> login(String email, String password) async {
    final token = await _authService.login(email: email, password: password);
    if (token!=null) {
      await _storageService.saveToken(token);
      return token;
    }
    return null;
  }

  Future<bool> validate({required String token}) async {
    final valid = await _authService.validate(token: token);
    if (valid) {
      return true;
    }
    return false;
  }

  Future<String?> getToken() async {
    return await _storageService.getToken();
  }

  Future<void> logout() async {
    await _storageService.deleteToken();
  }

}