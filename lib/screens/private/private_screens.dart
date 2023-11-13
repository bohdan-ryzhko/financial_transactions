import 'package:financial_transactions/screens/private/calculations/calculations.dart';
import 'package:financial_transactions/screens/private/graph/graph.dart';
import 'package:financial_transactions/screens/private/transactions/transactions.dart';
import 'package:flutter/material.dart';

class PrivateScreens extends StatefulWidget {
  const PrivateScreens({super.key});

  @override
  State<PrivateScreens> createState() => _PrivateScreensState();
}

class _PrivateScreensState extends State<PrivateScreens> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Center(
        child: [
          const Transactions(),
          const Graph(),
          // const Calculations(),
        ].elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.signal_cellular_alt),
            label: 'Transactions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.signal_cellular_alt),
            label: 'Graph',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.signal_cellular_alt),
          //   label: 'Calculations',
          // ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: theme.primaryColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
