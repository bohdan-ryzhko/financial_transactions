import 'package:financial_transactions/components/components.dart';
import 'package:financial_transactions/screens/public/registration/registration_form.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Registration",
          style: theme.primaryTextTheme.displaySmall,
        ),
        toolbarHeight: 100,
      ),
      body: const BackdropComponent(component: RegistrationForm()),
    );
  }
}
