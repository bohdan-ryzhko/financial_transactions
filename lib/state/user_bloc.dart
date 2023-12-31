import 'package:dio/dio.dart';
import 'package:financial_transactions/utils/utils.dart';
import 'package:flutter/material.dart';

class LoadingUserState extends UserState {}

class UserState {
  String? email;
  String? name;
  String? password;
  String token = "";

  final Dio _dio = Dio();
  final String _baseUrl = 'http://localhost:8000/api/auth';

  Dio get dio => _dio;
  String get baseUrl => _baseUrl;

  UserState({
    this.email,
    this.name,
    this.password,
  });

  factory UserState.initial() {
    return UserState(
      email: null,
      name: null,
      password: null,
    );
  }

  Future<void> registration({
    required String email,
    required String name,
    required String password,
  }) async {
    try {
      final Map<String, dynamic> data = {
        "email": email,
        "name": name,
        "password": password,
      };

      Response<Map<String, dynamic>> response =
          await dio.post("$baseUrl/registration", data: data);

      if (response.statusCode != 201) {
        throw Exception(response);
      }

      this.email = response.data!["email"] ?? "";
      this.name = response.data!["name"] ?? "";
      this.password = response.data!["password"] ?? "";
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      final Map<String, dynamic> data = {
        "email": email,
        "password": password,
      };

      Response<Map<String, dynamic>> response =
          await dio.post("$baseUrl/login", data: data);

      await LocalStorageApi.setToken(response.data!["token"]);

      if (response.statusCode != 201) {
        throw Exception(response);
      }

      email = response.data!["email"] ?? "";
      name = response.data!["name"] ?? "";
      token = response.data!["token"] ?? "";
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  Future<void> logout() async {
    try {
      await LocalStorageApi.resetToken();

      dio.options.headers['Authorization'] = 'Bearer $token';
      await dio.post("$baseUrl/logout");

      email = "";
      name = "";
      password = "";
      token = "";

      debugPrint(await LocalStorageApi.getToken());
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  Future<void> refresh(String token) async {
    try {
      if (token != "") {
        dio.options.headers['Authorization'] = 'Bearer $token';

        Response<Map<String, dynamic>> response =
            await dio.post("$baseUrl/refresh");

        email = response.data!["email"] ?? "";
        name = response.data!["name"] ?? "";
        password = response.data!["password"] ?? "";
      }
    } catch (error) {
      debugPrint(error.toString());
    }
  }
}
