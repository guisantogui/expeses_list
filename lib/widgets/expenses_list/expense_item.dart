import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  final Expense expense;

  ExpenseItem(this.expense);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 15,
          ),
          child: Column(
            children: [
              Text(expense.title),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Text("\$${expense.amount.toStringAsFixed(2)}"),
                  const Spacer(),
                  Row(
                    children: [
                      Icon(
                        categoryIcons[expense.category],
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Text(
                        expense.formattedDate
                      )
                    ],
                  )
                ],
              )
            ],
          )),
    );
  }
}