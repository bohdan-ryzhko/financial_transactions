import 'package:financial_transactions/components/components.dart';
import 'package:financial_transactions/state/state.dart';
import 'package:flutter/material.dart';

class Calculations extends StatefulWidget {
  const Calculations({super.key});

  @override
  State<Calculations> createState() => _CalculationsState();
}

class _CalculationsState extends State<Calculations> {
  AppBloc appBloc = AppBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text("Welcome, ${appBloc.user.name}"),
            const Text("Calculations"),
            const LogoutButton(),
          ],
        ),
      ),
    );
  }
}
