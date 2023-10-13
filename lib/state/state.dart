import 'package:financial_transactions/state/financial_bloc.dart';
import 'package:financial_transactions/state/user_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FinancialObserver extends BlocObserver {
  const FinancialObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    // ignore: avoid_print
    print('${bloc.runtimeType} $change');
  }
}

class AppBloc {
  final FinancialObserver observer = const FinancialObserver();

  static final AppBloc _instance = AppBloc._internal();

  factory AppBloc() {
    return _instance;
  }

  AppBloc._internal();

  UserState user = UserState.initial();
  TransactionsState transactions = TransactionsState.initial();
}
