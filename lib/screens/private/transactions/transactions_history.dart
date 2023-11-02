import 'package:financial_transactions/components/components.dart';
import 'package:financial_transactions/screens/private/transactions/dropdown_menu.dart';
import 'package:financial_transactions/state/account_bloc.dart';
import 'package:financial_transactions/state/financial_bloc.dart';
import 'package:financial_transactions/state/state.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const List<String> transactionsTypeList = <String>['Revenues', 'Expenses'];

class TransactionsHistory extends StatefulWidget {
  final Account account;

  const TransactionsHistory({
    Key? key,
    required this.account,
  }) : super(key: key);

  @override
  State<TransactionsHistory> createState() => _TransactionsHistoryState();
}

class _TransactionsHistoryState extends State<TransactionsHistory>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final appBloc = AppBloc();
  final _formKey = GlobalKey<FormState>();

  String? name = "";
  Account? account;

  List<Transaction> transactionsRevenues = [];
  List<Transaction> transactionsExpenses = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    setState(() {
      account = widget.account;
    });

    appBloc.transactions
        .getRevenues(accountId: account!.id)
        .then((transactionsList) {
      setState(() {
        transactionsRevenues = transactionsList;
      });
    }).catchError((error) {
      setState(() {
        transactionsRevenues = [];
      });
    });

    appBloc.transactions
        .getExpenses(accountId: account!.id)
        .then((transactionsList) {
      setState(() {
        transactionsExpenses = transactionsList;
      });
    }).catchError((error) {
      setState(() {
        transactionsExpenses = [];
      });
    });

    setState(() {
      name = appBloc.user.name;
    });
  }

  final amountController = TextEditingController();
  final dateController = TextEditingController();
  final descrController = TextEditingController();
  String selectedTransactionType = transactionsTypeList.first;

  DateTime selectedDate = DateTime.now();

  void createTransaction() {
    debugPrint(dateController.text);
    appBloc.transactions
        .addTransaction(
      accountId: account!.id,
      amount: amountController.text,
      transaction_date: dateController.text,
      transaction_description: descrController.text,
      transaction_type: selectedTransactionType.toLowerCase(),
    )
        .then((Transaction newTransaction) {
      if (newTransaction.transaction_type == TransactionType.revenues) {
        setState(() {
          transactionsRevenues = [...transactionsRevenues, newTransaction];
        });
        return;
      } else if (newTransaction.transaction_type == TransactionType.expenses) {
        setState(() {
          transactionsExpenses = [...transactionsExpenses, newTransaction];
        });
        return;
      }
    }).catchError((error) {
      debugPrint(error.toString());
    });
  }

  void onDeleteTransaction(Transaction transaction) {
    appBloc.transactions
        .deleteTransaction(
      transaction: transaction,
      accountId: account!.id,
    )
        .then((deletedTransaction) {
      setState(() {
        if (deletedTransaction.transaction_type == TransactionType.expenses) {
          transactionsExpenses.removeWhere((item) => item.id == transaction.id);
        } else {
          transactionsRevenues.removeWhere((item) => item.id == transaction.id);
        }
      });
    }).catchError((error) {
      debugPrint(error.toString());
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
      });
    }
  }

  void modalCreateTransaction() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          height: MediaQuery.of(context).size.height * 0.5,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: const Icon(Icons.close),
                  ),
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(labelText: "Amount"),
                  controller: amountController,
                ),
                TextField(
                  controller: dateController,
                  readOnly: true,
                  onTap: () {
                    _selectDate(context);
                  },
                  decoration: const InputDecoration(
                    labelText: 'Date',
                  ),
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  maxLines: 5,
                  decoration: const InputDecoration(labelText: "Description"),
                  controller: descrController,
                ),
                SizedBox(
                  width: double.infinity,
                  child: TransactionTypeDropdown(
                    selectedTransactionType: selectedTransactionType,
                    onChanged: (String? value) {
                      setState(() {
                        selectedTransactionType = value!;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SubmitButton(
                      onSubmit: createTransaction,
                      buttonText: "Add transaction",
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(selectedTransactionType);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Welcome, $name"),
              Text(account!.account_name ?? "acc"),
              const LogoutButton(),
            ],
          ),
          bottom: TabBar(
            tabs: const <Widget>[
              Tab(
                icon: Icon(Icons.arrow_downward),
                text: "Revenues",
              ),
              Tab(
                icon: Icon(Icons.arrow_upward),
                text: "Expenses",
              ),
            ],
            controller: _tabController,
          ),
        ),
        body: Stack(
          children: <Widget>[
            TabBarView(
              controller: _tabController,
              children: <Widget>[
                ListView.separated(
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider(
                      height: 2,
                      color: Color.fromARGB(255, 119, 146, 132),
                    );
                  },
                  itemCount: transactionsRevenues.length,
                  itemBuilder: (BuildContext context, int index) {
                    return transactionsRevenues.isNotEmpty
                        ? TransactionItem(
                            transaction: transactionsRevenues[index],
                            onDeleteTransaction: onDeleteTransaction,
                          )
                        : const CircularProgressIndicator();
                  },
                ),
                ListView.separated(
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider(
                      height: 2,
                      color: Color.fromARGB(255, 134, 102, 102),
                    );
                  },
                  itemCount: transactionsExpenses.length,
                  itemBuilder: (BuildContext context, int index) {
                    return transactionsExpenses.isNotEmpty
                        ? TransactionItem(
                            transaction: transactionsExpenses[index],
                            onDeleteTransaction: onDeleteTransaction,
                          )
                        : const CircularProgressIndicator();
                  },
                ),
              ],
            ),
            Positioned(
              bottom: 30,
              right: 70,
              child: FloatingActionButton(
                onPressed: modalCreateTransaction,
                child: const Icon(Icons.add),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
