import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  Future<String?> login({required String email, required String password}) async {
    final url = Uri.parse('http://10.0.2.2:8080/v1/token');
    print("from login service");
    final String basicAuth = 'Basic ' + base64Encode(utf8.encode('$email:$password'));

    final response = await http.post(
      url,
      body: jsonEncode({'username': email, 'password': password}),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': basicAuth,
        }
    );

    if (response.statusCode == 200) {
      // Login successful
      print(response.body);
      print('login successful');
      final Map<String, dynamic> data = jsonDecode(response.body);
      final accessKey = data['loginAccessKey']; // The JWT token
      return accessKey;
    } else {
      print('login failed');
      // Login failed
      return null;
    }
  }
  Future<bool> validate({required String token}) async {
    print('Token to validate');
    print(token);
    final url = Uri.parse('http://10.0.2.2:8080/v1/token/validate');
    final String bearerToken = 'Bearer $token';
    
    final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': bearerToken,
        }
    );
    print(response.statusCode);
    if (response.statusCode == 204) {
      // Validate successful
      print('validation successful');

      return true;
    } else {
      print('validation failed');
      // Login failed
      return false;
    }
  }
}
