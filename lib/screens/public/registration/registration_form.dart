import 'package:dio/dio.dart';
import 'package:financial_transactions/components/components.dart';
import 'package:flutter/material.dart';

class Auth {
  Dio dio = Dio();
  String baseUrl = 'http://localhost:8000/api/auth';

  Future<void> register(data) async {
    try {
      final response = await dio.post("$baseUrl/registration", data: data);
      debugPrint(response.toString());
    } catch (error) {
      debugPrint(error.toString());
    }
  }
}

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  RegistrationFormState createState() {
    return RegistrationFormState();
  }
}

class RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void onRegistration() async {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processing Data')),
      );
    }

    final registrationOnfo = {
      "name": nameController.text,
      "email": emailController.text,
      "password": passwordController.text,
    };

    Auth().register(registrationOnfo);
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
            controller: nameController,
            decoration: const InputDecoration(labelText: "Name"),
          ),
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            controller: emailController,
            decoration: const InputDecoration(labelText: "Email"),
          ),
          TextFormField(
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            controller: passwordController,
            decoration: const InputDecoration(labelText: "Password"),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SubmitButton(
                onSubmit: onRegistration,
                buttonText: "Registration",
              ),
            ),
          )
        ],
      ),
    );
  }
}
