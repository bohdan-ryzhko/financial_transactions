import 'package:financial_transactions/components/components.dart';
import 'package:financial_transactions/screens/screens.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Login",
          style: theme.primaryTextTheme.displaySmall,
        ),
        toolbarHeight: 100,
      ),
      body: const BackdropComponent(component: LoginForm()),
    );
  }
}
