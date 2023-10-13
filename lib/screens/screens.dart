import 'package:financial_transactions/screens/private/private_screens.dart';
import 'package:financial_transactions/screens/public/public_screens.dart';
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
  late AppBloc appBloc;
  int _selectedIndex = 0;
  String token = "";

  List<Widget> _widgetOptions = [];
  List<BottomNavigationBarItem> _bottomItems = [];

  Future<String?> _loadToken() async {
    String? localToken = await LocalStorageApi.getToken();
    setState(() {
      token = localToken ?? "";
    });

    return token;
  }

  @override
  void initState() {
    super.initState();

    appBloc = AppBloc();
    _loadToken().then((loadedToken) {
      setState(() {
        token = loadedToken ?? "";
        appBloc.user.refresh(token);
        _widgetOptions = defineNavigation.getRoutes(token);
        _bottomItems = defineNavigation.getNavigationsBottomItems(token);
      });
    });
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

    setState(() {
      if (token != "") {
        _widgetOptions = [
          const PrivateBar(),
        ];
        _bottomItems = [
          const BottomNavigationBarItem(
            icon: Icon(Icons.signal_cellular_alt),
            label: 'Private',
          ),
        ];
      } else {
        _widgetOptions = [
          const PublicBar(),
        ];
        _bottomItems = [
          const BottomNavigationBarItem(
            icon: Icon(Icons.signal_cellular_alt),
            label: 'Public',
          ),
        ];
      }
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
