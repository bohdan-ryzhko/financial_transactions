import 'package:dio/dio.dart';
import 'package:financial_transactions/utils/local_storage_api.dart';
import 'package:flutter/material.dart';

class Account {
  final String? id;
  final num? owner_id;
  final String? account_name;

  Account({
    this.id,
    this.owner_id,
    this.account_name,
  });

  factory Account.initial() {
    return Account(
      id: null,
      owner_id: null,
      account_name: null,
    );
  }
}

class AccountState {
  List<Account> accounts = [];
  final Dio _dio = Dio();
  final String _baseUrl = 'http://localhost:8000/api/accounts';

  Dio get dio => _dio;
  String get baseUrl => _baseUrl;

  AccountState({
    this.accounts = const [],
  });

  factory AccountState.initial() {
    return AccountState(
      accounts: [],
    );
  }

  Future<List<Account>> getAccounts() async {
    try {
      String? token = await LocalStorageApi.getToken();
      dio.options.headers['Authorization'] = 'Bearer $token';
      debugPrint(token);

      Response<List<dynamic>> response = await dio.get(baseUrl);

      if (response.data != null) {
        List<Account> accountsList = (response.data as List<dynamic>)
            .map(
              (dynamic account) => Account(
                id: account['id'],
                owner_id: account['owner_id'],
                account_name: account['account_name'],
              ),
            )
            .toList();
        return accountsList;
      } else {
        return [];
      }
    } catch (error) {
      debugPrint(error.toString());
      return [];
    }
  }

  Future<Account> addAccount({
    required String account_name,
  }) async {
    final data = {
      "account_name": account_name,
    };
    try {
      String? token = await LocalStorageApi.getToken();
      dio.options.headers['Authorization'] = 'Bearer $token';

      Response<Map<String, dynamic>> response =
          await dio.post(baseUrl, data: data);

      if (response.data != null) {
        final accountData = response.data as Map<String, dynamic>;
        final createdAccount = Account(
          id: accountData['id'],
          owner_id: accountData['owner_id'],
          account_name: accountData['account_name'],
        );

        return createdAccount;
      } else {
        throw Exception('Failed to create a transaction');
      }
    } catch (error) {
      debugPrint(error.toString());
      throw Exception('Failed to create a account');
    }
  }

  Future<Account> deleteAccount({
    required Account account,
  }) async {
    try {
      String? token = await LocalStorageApi.getToken();
      dio.options.headers['Authorization'] = 'Bearer $token';

      await dio.delete("$baseUrl/${account.id}");

      return account;
    } catch (error) {
      debugPrint(error.toString());
      throw Exception('Failed to delete a account');
    }
  }
}
