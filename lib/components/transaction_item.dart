import 'package:financial_transactions/state/financial_bloc.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class TransactionItem extends StatelessWidget {
  final Transaction transaction;
  final String transactionType;

  const TransactionItem({
    Key? key,
    required this.transaction,
    required this.transactionType,
  }) : super(key: key);

  Future<void> onShare() async {
    try {
      await Share.share(
        "Amount: ${transaction.amount}\nDescription: ${transaction.transaction_description}",
        subject: 'some subject',
      );
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: transactionType == "expenses"
          ? const Color.fromARGB(255, 255, 205, 205)
          : const Color.fromARGB(255, 197, 233, 215),
      title: Text("Amount: ${transaction.amount}"),
      subtitle: Text(
          "Date: ${transaction.transaction_date}\nDescription: ${transaction.transaction_description}\nType: ${transaction.transaction_type}"),
      trailing: IconButton(
        icon: const Icon(Icons.ios_share),
        onPressed: onShare,
      ),
    );
  }
}
