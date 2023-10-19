import 'package:financial_transactions/components/components.dart';
import 'package:financial_transactions/screens/private/private_screens.dart';
import 'package:financial_transactions/state/state.dart';
import 'package:financial_transactions/utils/utils.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  LoginFormState createState() {
    return LoginFormState();
  }
}

class LoginFormState extends State<LoginForm> {
  final appBloc = AppBloc();
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLoading = false;

  void onLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processing Data')),
      );
    }

    await appBloc.user.login(
      email: emailController.text,
      password: passwordController.text,
    );

    final data = {
      "email": emailController.text,
      "password": passwordController.text
    };

    String? token = await LocalStorageApi.getToken();

    debugPrint("token in login: $token");
    debugPrint("data in login: ${data.toString()}");

    if (token != null) {
      if (!context.mounted) return;

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const PrivateScreens(),
        ),
      );
    }

    setState(() {
      isLoading = false;
    });
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
              child: isLoading
                  ? const CircularProgressIndicator()
                  : SubmitButton(
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
