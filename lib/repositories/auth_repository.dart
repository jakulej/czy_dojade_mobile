import 'dart:convert';

import '../models/user.dart';
import 'package:http/http.dart' as http;

class AuthRepository {
  User? _user;
  final String baseUrl;


  AuthRepository(this.baseUrl);

  User? get user => _user;

  Future<User> createUserWithEmail(
      String email, String password, String name, String lastName) async {
    final result = await http.post(
      Uri.parse(
          '$baseUrl/api/auth/register'),
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
    if (result.statusCode == 200) {
      _user = User.fromJson(jsonDecode(result.body));
      _user = await getMe() ?? _user;
      return user!;
    } else {
      throw AuthException(message: 'Failed to register');
    }
  }

  Future<User> loginEmail(String email, String password) async {
    final result = await http.post(
      Uri.parse(
          '$baseUrl/api/auth/authenticate'),
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
      _user = await getMe() ?? _user;
      return user!;
    } else {
      throw AuthException(message: 'Failed to login');
    }
  }

  Future<User?> getMe() async {
    final result = await http.get(
      Uri.parse(
          '$baseUrl/api/user/me'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${_user!.token}'
      }
    );
    if (result.statusCode == 200) {
      _user = User.fullFromJson(jsonDecode(result.body));
      return user;
    }
    return null;
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