import 'package:financial_transactions/screens/private/calculations/calculations.dart';
import 'package:financial_transactions/screens/private/graph/graph.dart';
import 'package:financial_transactions/screens/private/transactions/transactions.dart';
import 'package:financial_transactions/state/state.dart';
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
  final appBloc = AppBloc();
  int _selectedIndex = 0;
  String token = "";

  List<Widget> _widgetOptions = [];
  List<BottomNavigationBarItem> _bottomItems = [];

  @override
  void initState() {
    debugPrint('Email: ${appBloc.user.email}');
    super.initState();
    setState(() {
      _widgetOptions = defineNavigation.getRoutes(token);
      _bottomItems = defineNavigation.getNavigationsBottomItems(token);
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void didUpdateWidget(covariant ScreensNavigation oldWidget) {
    super.didUpdateWidget(oldWidget);

    final newToken = localStorage.getToken();

    debugPrint(
      "newToken: $newToken",
    );

    if (newToken != "") {
      setState(() {
        token = newToken;
        _widgetOptions = [
          const Transactions(),
          const Graph(),
          const Calculations(),
        ];
        _bottomItems = [
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
      });
    }
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
