import 'package:financial_transactions/components/components.dart';
import 'package:financial_transactions/state/state.dart';
import 'package:financial_transactions/utils/local_storage_api.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Transactions extends StatefulWidget {
  const Transactions({Key? key}) : super(key: key);

  @override
  TransactionsState createState() => TransactionsState();
}

class TransactionsState extends State<Transactions>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _formKey = GlobalKey<FormState>();

  bool isModalOpen = false;

  final appBloc = AppBloc();

  String? name = "";

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    setState(() {
      name = appBloc.user.name;
    });
  }

  void handleNavigationTap(int index) {
    switch (index) {
      case 0:
        debugPrint("curr index = $index, ${appBloc.user.name}");
        break;
      case 1:
        debugPrint("curr index = $index, ${appBloc.user.email}");
        break;
      default:
        debugPrint("curr index = $index, ${appBloc.user}");
        break;
    }
  }

  DateTime selectedDate = DateTime.now();

  final amountController = TextEditingController();
  final dateController = TextEditingController();
  final descrController = TextEditingController();
  String? selectedValue;

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

  Future<void> addTransaction() async {
    debugPrint('amountController, ${amountController.text}');
    debugPrint('dateController, ${dateController.text}');
    debugPrint('descrController, ${descrController.text}');
    debugPrint('selectedValue, $selectedValue');

    String? token = await LocalStorageApi.getToken();

    appBloc.transactions.addTransaction(
      amount: amountController.text,
      transaction_date: dateController.text,
      transaction_description: descrController.text,
      transaction_type: selectedValue?.toLowerCase(),
      token: token,
    );
  }

  void modalCreateOrder() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          height: MediaQuery.of(context).size.height * 0.5,
          child: Stack(
            children: [
              Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          decoration:
                              const InputDecoration(labelText: "Amount"),
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
                          decoration:
                              const InputDecoration(labelText: "Description"),
                          controller: descrController,
                        ),
                        DropdownButton<String>(
                          value: selectedValue,
                          onChanged: (String? newValue) {
                            // debugPrint(newValue);
                            // debugPrint(selectedValue);
                            setState(() {
                              selectedValue = newValue;
                            });
                          },
                          items: <String>[
                            'Revenues',
                            'Expenses',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                        SubmitButton(
                            onSubmit: addTransaction,
                            buttonText: "Add Transaction")
                      ],
                    ),
                  )
                ],
              ),
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: const Icon(Icons.close),
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
              const Text("Calculations"),
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
            onTap: handleNavigationTap,
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(30),
                ),
                onPressed: modalCreateOrder,
                child: const Icon(Icons.add),
              ),
            ),
            const Center(
              child: Text("It's rainy here"),
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
