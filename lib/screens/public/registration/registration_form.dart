import 'package:financial_transactions/components/components.dart';
import 'package:financial_transactions/screens/private/private_screens.dart';
import 'package:financial_transactions/state/state.dart';
import 'package:financial_transactions/utils/utils.dart';
import 'package:flutter/material.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  RegistrationFormState createState() {
    return RegistrationFormState();
  }
}

class RegistrationFormState extends State<RegistrationForm> {
  final appBloc = AppBloc();
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLoading = false;

  void onRegistration() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processing Data')),
      );
    }

    await appBloc.user.registration(
      email: emailController.text,
      name: nameController.text,
      password: passwordController.text,
    );

    await appBloc.user.login(
      email: emailController.text,
      password: passwordController.text,
    );

    String? token = await LocalStorageApi.getToken();

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
              child: isLoading
                  ? const CircularProgressIndicator()
                  : SubmitButton(
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
