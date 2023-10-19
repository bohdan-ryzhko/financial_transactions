import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

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

  Future<void> getTransactions({
    required String typeTransactions,
  }) async {
    try {
      Response<Map<String, dynamic>> response =
          await dio.get("$baseUrl/$typeTransactions");

      debugPrint(response.data.toString());
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  Future<void> addTransaction({
    required String amount,
    required String transaction_date,
    required String transaction_description,
    required String? transaction_type,
    required String? token,
  }) async {
    try {
      final data = {
        "amount": double.parse(amount),
        "transaction_date": transaction_date,
        "transaction_description": transaction_description,
        "transaction_type": transaction_type,
      };

      dio.options.headers['Authorization'] = 'Bearer $token';

      Response<Map<String, dynamic>> response =
          await dio.post(baseUrl, data: data);

      debugPrint(response.toString());
    } catch (error) {
      debugPrint(error.toString());
    }
  }
}
