import 'package:dio/dio.dart';
import 'package:financial_transactions/utils/local_storage_api.dart';
import 'package:flutter/material.dart';

enum TransactionType {
  revenues,
  expenses,
}

class Transaction {
  final String? id;
  final num? amount;
  final num? owner_id;
  final String? transaction_date;
  final String? transaction_description;
  final TransactionType? transaction_type;

  Transaction({
    this.id,
    this.owner_id,
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
  List<Transaction> transactions = [];
  final Dio _dio = Dio();
  final String _baseUrl = 'http://localhost:8000/api/transactions';

  Dio get dio => _dio;
  String get baseUrl => _baseUrl;

  TransactionsState({
    this.transactions = const [],
  });

  factory TransactionsState.initial() {
    return TransactionsState(
      transactions: [],
    );
  }

  Future<List<Transaction>> getTransactions({
    required String typeTransaction,
  }) async {
    try {
      String? token = await LocalStorageApi.getToken();
      dio.options.headers['Authorization'] = 'Bearer $token';

      Response<List<dynamic>> response =
          await dio.get("$baseUrl/$typeTransaction");

      if (response.data != null) {
        List<Transaction> transactionsList = (response.data as List<dynamic>)
            .map((dynamic transaction) => Transaction(
                  id: transaction['id'],
                  amount: transaction['amount'],
                  transaction_date: transaction['transaction_date'],
                  transaction_description:
                      transaction['transaction_description'],
                  transaction_type: TransactionType.values.firstWhere((e) =>
                      e.toString().split('.').last ==
                      transaction['transaction_type']),
                ))
            .toList();
        debugPrint("transactions ${transactionsList.length}");
        return transactionsList;
      } else {
        return [];
      }
    } catch (error) {
      debugPrint(error.toString());
      return [];
    }
  }

  Future<void> addTransaction({
    required String amount,
    required String transaction_date,
    required String transaction_description,
    required String? transaction_type,
  }) async {
    try {
      final data = {
        "amount": double.parse(amount),
        "transaction_date": transaction_date,
        "transaction_description": transaction_description,
        "transaction_type": transaction_type,
      };

      String? token = await LocalStorageApi.getToken();

      dio.options.headers['Authorization'] = 'Bearer $token';

      Response<Map<String, dynamic>> response =
          await dio.post(baseUrl, data: data);

      debugPrint(response.toString());
    } catch (error) {
      debugPrint(error.toString());
    }
  }
}
