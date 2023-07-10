import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:flutter/material.dart';
import '../models/expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
        amount: 15,
        title: "Flutter Course",
        date: DateTime.now(),
        category: Category.work),
    Expense(
        amount: 55,
        title: "Meat",
        date: DateTime.now(),
        category: Category.food),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        const Text("CHART"),
        Expanded(
          child: ExpensesList(expenses: _registeredExpenses),
        ),
      ],
    ));
  }
}
