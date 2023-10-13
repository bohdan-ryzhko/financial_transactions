import 'package:financial_transactions/screens/private/calculations/calculations.dart';
import 'package:financial_transactions/screens/private/graph/graph.dart';
import 'package:financial_transactions/screens/private/transactions/transactions.dart';
import 'package:flutter/material.dart';

class PrivateBar extends StatelessWidget {
  const PrivateBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: PrivateNavigation());
  }
}

class PrivateNavigation extends StatefulWidget {
  const PrivateNavigation({super.key});

  @override
  State<PrivateNavigation> createState() => _PrivateNavigationState();
}

class _PrivateNavigationState extends State<PrivateNavigation> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.amber[800],
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Transactions',
          ),
          NavigationDestination(
            icon: Icon(Icons.business),
            label: 'Calculations',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.school),
            icon: Icon(Icons.school_outlined),
            label: 'Graph',
          ),
        ],
      ),
      body: <Widget>[
        const Transactions(),
        const Graph(),
        const Calculations(),
      ][currentPageIndex],
    );
  }
}
