import 'package:financial_transactions/state/state.dart';
import 'package:flutter/material.dart';

class Transactions extends StatefulWidget {
  const Transactions({Key? key}) : super(key: key);

  @override
  _TransactionsState createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final appBloc = AppBloc();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  void handleNavigationTap(int index) {
    switch (index) {
      case 0:
        debugPrint("curr index = $index, ${appBloc.user.name}");
        break;
      case 1:
        debugPrint("curr index = $index, ${appBloc.user.email}");
        break;
      default:
        debugPrint("curr index = $index, ${appBloc.user}");
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Transactions"),
          bottom: TabBar(
            tabs: const <Widget>[
              Tab(
                icon: Icon(Icons.arrow_downward),
                text: "Revenues",
              ),
              Tab(
                icon: Icon(Icons.arrow_upward),
                text: "Expenses",
              ),
            ],
            controller: _tabController,
            onTap: handleNavigationTap,
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: const <Widget>[
            Center(
              child: Text("It's cloudy here"),
            ),
            Center(
              child: Text("It's rainy here"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
