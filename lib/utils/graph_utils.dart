import 'package:financial_transactions/state/financial_bloc.dart';

Map<String, Object?> mapTransactions(Transaction transaction) {
  return {
    "date": transaction.transaction_date,
    "amount": transaction.amount!.toDouble(),
  };
}

num calculateAmount(num? value, num? element) {
  if (value != null && element != null) {
    return value + element;
  }
  return 0;
}

int sortedTransactions(dynamic a, dynamic b) {
  final dateA = DateTime.parse(a["date"]);
  final dateB = DateTime.parse(b["date"]);
  return dateA.compareTo(dateB);
}
