import 'package:financial_transactions/screens/private/private_screens.dart';
import 'package:financial_transactions/screens/public/public_screens.dart';
import 'package:financial_transactions/state/state.dart';
import 'package:financial_transactions/utils/utils.dart';
import 'package:flutter/material.dart';

export 'public/login/login_form.dart';
export 'public/registration/registration_form.dart';

class Screens extends StatelessWidget {
  const Screens({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ScreensNavigation(),
    );
  }
}

class ScreensNavigation extends StatefulWidget {
  const ScreensNavigation({super.key});

  @override
  State<ScreensNavigation> createState() => _ScreensNavigationState();
}

class _ScreensNavigationState extends State<ScreensNavigation> {
  AppBloc appBloc = AppBloc();
  String token = "";

  @override
  void initState() {
    super.initState();
    _initializeToken();
  }

  Future<void> _initializeToken() async {
    final retrievedToken = await LocalStorageApi.getToken();
    setState(() {
      token = retrievedToken ?? "";
    });

    appBloc.user.refresh(token);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: LocalStorageApi.getToken(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          token = snapshot.data ?? "";

          if (token.isEmpty) {
            return const PublicScreens();
          } else {
            return const PrivateScreens();
          }
        }
      },
    );
  }
}
