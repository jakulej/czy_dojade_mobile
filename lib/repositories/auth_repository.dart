import 'dart:convert';

import '../models/user.dart';
import 'package:http/http.dart' as http;

class AuthRepository {

  static String ip = "192.168.100.8";

  User? _user;

  AuthRepository();

  User? get user => _user;
  bool get isLoggedIn => _user != null;

  Future<User> createUserWithEmail(
      String email, String password, String name, String lastName) async {
    print('ip $ip');
    final result = await http.post(
      Uri.parse('http://$ip:8080/api/auth/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'hashPassword': password,
        'firstName': name,
        'lastName': lastName,
      }),
    );
    if (result.statusCode == 201) {
      _user = User.fromJson(jsonDecode(result.body));
      await getMe();
      return user!;
    } else {
      throw AuthException(message: 'Failed to register');
    }
  }

  Future<User> loginEmail(String email, String password) async {
    print('ip $ip');
    final result = await http.post(
      Uri.parse('http://$ip:8080/api/auth/authenticate'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'hashPassword': password,
      }),
    );
    if (result.statusCode == 200) {
      _user = User.fromJson(jsonDecode(result.body));
      await getMe();
      return user!;
    } else {
      throw AuthException(message: 'Failed to login');
    }
  }

  Future<void> getMe() async {
    print('ip $ip');
    final result = await http
        .get(Uri.parse('http://$ip:8080/api/user/me'), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${_user!.token}'
    });
    if (result.statusCode == 200) {
      _user?.fillFromJson(jsonDecode(result.body));
      return;
    }
    return;
  }

  void logout() {
    _user = null;
  }
}

class AuthException implements Exception {
  final String message;

  AuthException({required this.message});

  @override
  String toString() {
    return message;
  }
}
