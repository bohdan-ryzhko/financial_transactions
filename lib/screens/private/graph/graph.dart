import 'package:financial_transactions/components/components.dart';
import 'package:financial_transactions/state/state.dart';
import 'package:flutter/material.dart';

class Graph extends StatefulWidget {
  const Graph({super.key});

  @override
  State<Graph> createState() => _GraphState();
}

class _GraphState extends State<Graph> {
  AppBloc appBloc = AppBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text("Welcome, ${appBloc.user.name}"),
            const Text("Graph"),
            const LogoutButton(),
          ],
        ),
      ),
    );
  }
}
