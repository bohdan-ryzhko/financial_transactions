import 'package:financial_transactions/screens/screens.dart';
import 'package:financial_transactions/state/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  Bloc.observer = const FinancialObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Scaffold(
        body: Screens(),
      ),
      theme: ThemeData(
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Colors.blueAccent,
          onPrimary: Colors.white,
          secondary: Colors.blue,
          onSecondary: Colors.white,
          error: Colors.redAccent,
          onError: Colors.redAccent,
          background: Colors.blueAccent,
          onBackground: Colors.blueAccent,
          surface: Colors.blueAccent,
          onSurface: Colors.blueAccent,
        ),
        primaryTextTheme: const TextTheme(
          displaySmall: TextStyle(
            color: Colors.white,
            fontSize: 10,
          ),
        ),
      ),
    );
  }
}
