import 'package:financial_transactions/utils/local_storage_api.dart';
import 'package:flutter/material.dart';

class Transactions extends StatelessWidget {
  const Transactions({super.key});

  void onPressed() {
    String token = localStorage.getToken();

    debugPrint(token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transactions"),
      ),
      body: ElevatedButton(
        onPressed: onPressed,
        child: const Text("click"),
      ),
    );
  }
}
