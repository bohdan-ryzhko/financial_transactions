import 'package:financial_transactions/components/components.dart';
import 'package:financial_transactions/state/financial_bloc.dart';
import 'package:financial_transactions/state/state.dart';
import 'package:financial_transactions/utils/get_graph.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Graph extends StatefulWidget {
  const Graph({super.key});

  @override
  State<Graph> createState() => _GraphState();
}

class _GraphState extends State<Graph> {
  AppBloc appBloc = AppBloc();

  List transactionsRevenues = [];
  List transactionsExpenses = [];
  num maxAmountRevenues = 0;
  num maxAmountExpenses = 0;

  List<LineChartBarData> graphs = [];
  List<List<Widget>> dates = [];

  int currentGraph = 0;
  String title = "Revenues";

  void incrementCurrentGraph() {
    if (currentGraph == graphs.length - 1) {
      setState(() {
        currentGraph = 0;
        title = "Revenues";
      });
      return;
    } else {
      setState(() {
        currentGraph += 1;
        title = "Expenses";
      });
    }
  }

  @override
  void initState() {
    super.initState();

    appBloc.transactions
        .getTransactions(typeTransaction: "revenues")
        .then((transactionsList) {
      setState(() {
        transactionsRevenues = transactionsList.map((Transaction transaction) {
          return {
            "date": transaction.transaction_date,
            "amount": transaction.amount!.toDouble(),
          };
        }).toList();

        transactionsRevenues.sort((a, b) {
          final dateA = DateTime.parse(a["date"]);
          final dateB = DateTime.parse(b["date"]);
          return dateA.compareTo(dateB);
        });

        graphs.add(
          LineChartBarData(
            spots: getGraph(transactionsRevenues),
            isCurved: true,
            belowBarData: BarAreaData(show: false),
            color: const Color.fromARGB(255, 137, 204, 171),
          ),
        );

        dates.add(getDates(transactionsRevenues));

        maxAmountRevenues = transactionsRevenues.isNotEmpty
            ? transactionsRevenues
                .map((entry) => entry['amount'] as double)
                .reduce((max, amount) => max > amount ? max : amount)
            : 0;
      });
    }).catchError((error) {
      setState(() {
        transactionsRevenues = [];
      });
    });

    appBloc.transactions
        .getTransactions(typeTransaction: "expenses")
        .then((transactionsList) {
      setState(() {
        transactionsExpenses = transactionsList.map((Transaction transaction) {
          return {
            "date": transaction.transaction_date,
            "amount": transaction.amount!.toDouble(),
          };
        }).toList();

        transactionsExpenses.sort((a, b) {
          final dateA = DateTime.parse(a["date"]);
          final dateB = DateTime.parse(b["date"]);
          return dateA.compareTo(dateB);
        });

        graphs.add(
          LineChartBarData(
            spots: getGraph(transactionsExpenses),
            isCurved: true,
            belowBarData: BarAreaData(show: false),
            color: const Color.fromARGB(255, 222, 159, 159),
          ),
        );

        dates.add(getDates(transactionsExpenses));

        maxAmountExpenses = transactionsExpenses.isNotEmpty
            ? transactionsExpenses
                .map((entry) => entry['amount'] as double)
                .reduce((max, amount) => max > amount ? max : amount)
            : 0;
      });
    }).catchError((error) {
      setState(() {
        transactionsExpenses = [];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text("Welcome, ${appBloc.user.name}"),
            const Text("Graph"),
            const LogoutButton(),
          ],
        ),
      ),
      body: transactionsRevenues.isNotEmpty
          ? Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: ElevatedButton(
                    onPressed: incrementCurrentGraph,
                    child: Text(title),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: LineChart(
                      LineChartData(
                        lineBarsData: [
                          graphs[currentGraph],
                        ],
                        minY: 0,
                        maxY: maxAmountRevenues + 100,
                        titlesData: FlTitlesData(
                          topTitles: const AxisTitles(
                            axisNameWidget: Text(""),
                          ),
                          rightTitles: const AxisTitles(
                            axisNameWidget: Text(""),
                          ),
                          bottomTitles: AxisTitles(
                            axisNameWidget: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: dates[currentGraph],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          : const Center(child: Text("You are not have transactions :(")),
    );
  }
}
