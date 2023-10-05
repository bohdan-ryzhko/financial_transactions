import 'package:dio/dio.dart';
import 'package:financial_transactions/utils/local_storage_api.dart';
import 'package:flutter/material.dart';

class LoginOnfo {
  final String _email = "";
  final String _password = "";

  String get email => _email;
  String get password => _password;

  set email(String value) {
    if (value.length < 6) {
      debugPrint("Email must have 6 characters");
      return;
    }

    email = value;
  }

  set password(String value) {
    if (value.length < 6) {
      debugPrint("Password must have 6 characters");
      return;
    }

    password = value;
  }
}

class RegistrationInfo extends LoginOnfo {
  final String _name = "";
  final String _token = "";

  String get name => _name;
  String get token => _token;

  set name(String value) {
    name = value;
  }

  set token(String value) {
    token = value;
  }
}

class AuthApi extends RegistrationInfo {
  final Dio _dio = Dio();
  final String _baseUrl = 'http://localhost:8000/api/auth';

  Dio get dio => _dio;
  String get baseUrl => _baseUrl;

  Future<void> register(Map<String, String> data) async {
    try {
      Response<Map<String, dynamic>> response =
          await dio.post("$baseUrl/registration", data: data);

      debugPrint(response.toString());

      if (response.statusCode != 201) {
        throw Exception(response);
      }

      login({"email": email, "password": password});

      email = data['email'] ?? "";
      name = data['name'] ?? "";
      password = data['password'] ?? "";
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  Future<void> login(Map<String, String> data) async {
    try {
      final response = await dio.post("$baseUrl/login", data: data);

      // debugPrint(response.toString());

      if (response.statusCode != 200) {
        throw Exception(response);
      }

      token = response.data.token;
      localStorage.setToken(token);
      debugPrint(localStorage.getToken());
    } catch (error) {
      debugPrint(error.toString());
    }
  }
}

AuthApi authApi = AuthApi();
