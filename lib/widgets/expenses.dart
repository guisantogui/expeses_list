import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
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

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) => NewExpense(onExpenseAdded: addExpense));
  }

  void setAddExpenseState(Expense expense, {int index = -1}) {
    setState(() {
      if (index < 0) {
        _registeredExpenses.add(expense);
      } else {
        _registeredExpenses.insert(index, expense);
      }
    });
  }

  void setRemoveExpenseState(Expense expense) {
    setState(() {
      _registeredExpenses.remove(expense);
    });
  }

  void addExpense(Expense expense, {int index = -1}) {
    setAddExpenseState(expense, index: index);
  }

  void removeExpense(Expense expense) {
    var index = _registeredExpenses.indexOf(expense);
    setRemoveExpenseState(expense);

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 5),
      content: const Text("Item deleted"),
      action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            addExpense(expense, index: index);
          }),
    ));
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text("There is no Expenses, start spending money"),
    );

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onItemRemoved: removeExpense,
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text("Expense Tracker"),
          actions: [
            IconButton(
              onPressed: _openAddExpenseOverlay,
              icon: const Icon(Icons.add),
            )
          ],
        ),
        body: Column(
          children: [
            Expanded(child: mainContent),
          ],
        ));
  }
}
