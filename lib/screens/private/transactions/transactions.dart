import 'package:financial_transactions/components/components.dart';
import 'package:financial_transactions/screens/private/transactions/accounts_carousel.dart';
import 'package:financial_transactions/state/account_bloc.dart';
import 'package:financial_transactions/state/state.dart';
import 'package:flutter/material.dart';

class Transactions extends StatefulWidget {
  const Transactions({Key? key}) : super(key: key);

  @override
  TransactionsState createState() => TransactionsState();
}

class TransactionsState extends State<Transactions>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _formKey = GlobalKey<FormState>();
  final appBloc = AppBloc();

  String? name = "";
  List<Account> accountsList = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    appBloc.account.getAccounts().then((List<Account> accounts) {
      setState(() {
        accountsList = accounts;
      });
    });

    setState(() {
      name = appBloc.user.name;
    });
  }

  DateTime selectedDate = DateTime.now();

  final accountNameController = TextEditingController();

  void createAccount() {
    appBloc.account
        .addAccount(account_name: accountNameController.text)
        .then((Account newAccount) =>
            setState(() => accountsList = [...accountsList, newAccount]))
        .catchError((error) => debugPrint(error.toString()));
  }

  void modalCreateAccount() {
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
                  decoration: const InputDecoration(labelText: "Account"),
                  controller: accountNameController,
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SubmitButton(
                      onSubmit: createAccount,
                      buttonText: "Add account",
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

  void onDeleteAccount(Account account) {
    appBloc.account
        .deleteAccount(account: account)
        .then(
          (Account deletedAccount) => setState(
            () => accountsList.removeWhere((item) => item.id == account.id),
          ),
        )
        .catchError((error) => debugPrint(error));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Welcome, $name"),
              const Text("Transactions"),
              const LogoutButton(),
            ],
          ),
        ),
        body: Stack(
          children: <Widget>[
            Center(
              child: AccountsCarousel(
                accounts: accountsList,
                onDeleteAccount: onDeleteAccount,
              ),
            ),
            Positioned(
              bottom: 30,
              right: 70,
              child: FloatingActionButton(
                onPressed: modalCreateAccount,
                child: const Icon(Icons.add),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
