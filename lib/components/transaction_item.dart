import 'package:financial_transactions/state/financial_bloc.dart';
import 'package:financial_transactions/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class TransactionItem extends StatelessWidget {
  final Transaction transaction;
  final void Function() Function(Transaction) onDeleteTransaction;

  const TransactionItem({
    Key? key,
    required this.transaction,
    required this.onDeleteTransaction,
  }) : super(key: key);

  Future<void> onShare() async {
    try {
      await Share.share(
        "Amount: ${transaction.amount}\nDescription: ${transaction.transaction_description}",
      );
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  String getTransactionType() {
    return transaction.transaction_type == TransactionType.expenses
        ? "expenses"
        : "revenues";
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: transaction.transaction_type == TransactionType.expenses
          ? const Color.fromARGB(255, 255, 205, 205)
          : const Color.fromARGB(255, 197, 233, 215),
      title: Text("Amount: ${transaction.amount}"),
      subtitle: Text(
          "Date: ${getLocalizationDate(transaction.transaction_date)}\nDescription: ${transaction.transaction_description}\nType: ${getTransactionType()}"),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.ios_share),
            onPressed: onShare,
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: onDeleteTransaction(transaction),
          ),
        ],
      ),
    );
  }
}
