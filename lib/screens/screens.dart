import 'package:financial_transactions/utils/utils.dart';
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
  String token = '';

  List<Widget> _widgetOptions = [];
  List<BottomNavigationBarItem> _bottomItems = [];

  @override
  void initState() {
    super.initState();
    _widgetOptions = defineNavigation.getRoutes(token);
    _bottomItems = defineNavigation.getNavigationsBottomItems(token);
  }

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
        items: _bottomItems,
        currentIndex: _selectedIndex,
        selectedItemColor: theme.primaryColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
