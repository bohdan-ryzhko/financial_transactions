import 'package:flutter/material.dart';

const List<String> transactionsTypeList = <String>['Revenues', 'Expenses'];

class TransactionTypeDropdown extends StatefulWidget {
  String selectedTransactionType;
  void Function(String?) onChanged;

  TransactionTypeDropdown({
    Key? key,
    required this.selectedTransactionType,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<TransactionTypeDropdown> createState() =>
      _TransactionTypeDropdownState();
}

class _TransactionTypeDropdownState extends State<TransactionTypeDropdown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: widget.selectedTransactionType,
      items: transactionsTypeList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: widget.onChanged,
    );
  }
}
