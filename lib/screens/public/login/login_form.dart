import 'package:financial_transactions/components/components.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class Auth {
  Dio dio = Dio();
  String baseUrl = 'http://localhost:8000/api/auth';

  Future<void> login(data) async {
    try {
      final response = await dio.post("$baseUrl/login", data: data);
      debugPrint(response.toString());
    } catch (error) {
      debugPrint(error.toString());
    }
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  LoginFormState createState() {
    return LoginFormState();
  }
}

class LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void onLogin() {
    final loginInfo = {
      "email": emailController.text,
      "password": passwordController.text,
    };

    debugPrint(loginInfo.toString());
    Auth().login(loginInfo);

    // try {
    //   final response =
    //       await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/ditto'));

    //   debugPrint(response.toString());
    // } catch (error) {
    //   debugPrint(error.toString());
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            decoration: const InputDecoration(labelText: "Email"),
            controller: emailController,
          ),
          TextFormField(
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            decoration: const InputDecoration(labelText: "Password"),
            controller: passwordController,
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SubmitButton(
                onSubmit: onLogin,
                buttonText: "Login",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
