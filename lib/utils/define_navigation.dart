import 'package:financial_transactions/screens/private/calculations/calculations.dart';
import 'package:financial_transactions/screens/private/graph/graph.dart';
import 'package:financial_transactions/screens/private/transactions/transactions.dart';
import 'package:financial_transactions/screens/public/login/login_screen.dart';
import 'package:financial_transactions/screens/public/registration/registration_screen.dart';
import 'package:flutter/material.dart';

class DefineNavigation {
  List<Widget> getRoutes(String? token) {
    if (token == "" || token == null) {
      return [const RegistrationScreen(), const LoginScreen()];
    }

    return [
      const Transactions(),
      const Graph(),
      const Calculations(),
    ];
  }

  List<BottomNavigationBarItem> getNavigationsBottomItems(String? token) {
    if (token == "" || token == null) {
      return [
        const BottomNavigationBarItem(
          icon: Icon(Icons.signal_cellular_alt),
          label: 'Registration',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.signal_cellular_alt),
          label: 'Login',
        ),
      ];
    }

    return [
      const BottomNavigationBarItem(
        icon: Icon(Icons.signal_cellular_alt),
        label: 'Transactions',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.signal_cellular_alt),
        label: 'Graph',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.signal_cellular_alt),
        label: 'Calculations',
      ),
    ];
  }
}

final defineNavigation = DefineNavigation();
