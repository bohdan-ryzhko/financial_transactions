import 'package:financial_transactions/screens/public/login/login_screen.dart';
import 'package:financial_transactions/screens/public/registration/registration_screen.dart';
import 'package:flutter/material.dart';

class PublicScreens extends StatefulWidget {
  const PublicScreens({super.key});

  @override
  State<PublicScreens> createState() => _PublicScreensState();
}

class _PublicScreensState extends State<PublicScreens> {
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
          const RegistrationScreen(),
          const LoginScreen(),
        ].elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.signal_cellular_alt),
            label: 'Registration',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.signal_cellular_alt),
            label: 'Login',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: theme.primaryColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
