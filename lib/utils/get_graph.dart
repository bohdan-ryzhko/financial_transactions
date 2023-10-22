import 'package:financial_transactions/utils/utils.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

List<FlSpot> getGraph(List<dynamic> transactions) {
  return transactions
      .asMap()
      .entries
      .map((entry) => FlSpot(
            entry.key.toDouble(),
            entry.value['amount'],
          ))
      .toList();
}

List<Widget> getDates(List<dynamic> transactions) {
  return transactions.map((data) {
    return Transform(
      transform: Matrix4.rotationZ(-0.75),
      child: Text(
        getLocalizationDate(data["date"]),
      ),
    );
  }).toList();
}
