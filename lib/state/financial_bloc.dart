enum TransactionType {
  revenues,
  expenses,
}

class Transaction {
  final String? id;
  final num? amount;
  final String? transaction_date;
  final String? transaction_description;
  final TransactionType? transaction_type;

  Transaction({
    this.id,
    this.amount,
    this.transaction_date,
    this.transaction_description,
    this.transaction_type,
  });

  factory Transaction.initial() {
    return Transaction(
      id: null,
      amount: null,
      transaction_date: null,
      transaction_description: null,
      transaction_type: null,
    );
  }
}

class TransactionsState {
  final List<Transaction> transactions;

  TransactionsState({
    this.transactions = const [],
  });

  factory TransactionsState.initial() {
    return TransactionsState(
      transactions: [],
    );
  }
}
