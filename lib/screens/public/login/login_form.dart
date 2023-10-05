import 'package:financial_transactions/components/components.dart';
import 'package:financial_transactions/utils/auth_api.dart';
import 'package:flutter/material.dart';

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

    authApi.login(loginInfo);

    debugPrint(loginInfo.toString());
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
