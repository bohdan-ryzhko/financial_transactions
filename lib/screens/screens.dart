import 'package:financial_transactions/screens/public/login/login_form.dart';
import 'package:financial_transactions/screens/public/login/login_screen.dart';
import 'package:financial_transactions/screens/public/registration/registration_form.dart';
import 'package:financial_transactions/screens/public/registration/registration_screen.dart';
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
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    RegistrationScreen(),
    LoginScreen(),
  ];

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
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
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
