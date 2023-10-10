import 'package:financial_transactions/screens/public/login/login_screen.dart';
import 'package:financial_transactions/screens/public/registration/registration_screen.dart';
import 'package:flutter/material.dart';

class PublicBar extends StatelessWidget {
  const PublicBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: PublicNavigation());
  }
}

class PublicNavigation extends StatefulWidget {
  const PublicNavigation({super.key});

  @override
  State<PublicNavigation> createState() => _PublicNavigationState();
}

class _PublicNavigationState extends State<PublicNavigation> {
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
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.business),
            label: 'Business',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.school),
            icon: Icon(Icons.school_outlined),
            label: 'School',
          ),
        ],
      ),
      body: <Widget>[
        const RegistrationScreen(),
        const LoginScreen(),
      ][currentPageIndex],
    );
  }
}
