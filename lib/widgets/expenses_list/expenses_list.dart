import '../../models/expense.dart';
import 'expense_item.dart';

import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  final List<Expense> expenses;
  final Function onItemRemoved;

  const ExpensesList(
      {super.key, required this.expenses, required this.onItemRemoved});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) => Dismissible(
        key: ValueKey(expenses[index]),
        child: ExpenseItem(expenses[index]),
        onDismissed: (direction) {
          onItemRemoved(index);
        },
      ),
    );
  }
}
