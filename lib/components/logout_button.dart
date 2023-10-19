import 'package:financial_transactions/screens/public/public_screens.dart';
import 'package:financial_transactions/state/state.dart';
import 'package:financial_transactions/utils/local_storage_api.dart';
import 'package:flutter/material.dart';

class LogoutButton extends StatefulWidget {
  const LogoutButton({super.key});

  @override
  State<LogoutButton> createState() => _LogoutButtonState();
}

class _LogoutButtonState extends State<LogoutButton> {
  final appBloc = AppBloc();
  final _formKey = GlobalKey<FormState>();

  void onLogout() async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processing Data')),
      );
    }

    await appBloc.user.logout();

    String? token = await LocalStorageApi.getToken();

    if (token == null) {
      if (!context.mounted) return;

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const PublicScreens(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all<Color>(theme.colorScheme.onPrimary),
      ),
      onPressed: onLogout,
      child: Text(
        "Logout",
        style: TextStyle(
          color: theme.colorScheme.primary,
        ),
      ),
    );
  }
}
