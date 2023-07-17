import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onExpenseAdded});

  final Function onExpenseAdded;

  @override
  State<StatefulWidget> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amoutController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leasure;

  void _onFormSubmitted() {
    var title = _titleController.text;
    var amount = double.tryParse(_amoutController.text);
    var amountIsValid = amount != null && amount > 0;

    if (title.isNotEmpty && amountIsValid && _selectedDate != null) {
      widget.onExpenseAdded(Expense(
        title: title,
        amount: amount,
        date: _selectedDate!,
        category: _selectedCategory,
      ));

      Navigator.pop(context);
    } else {
      ///POPUP ERROR MESSAGE
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Error Fill the form"),
          content: const Text("Please Fill the form"),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text("OK"))
          ],
        ),
      );
      return;
    }
  }

  void _onFormCancelled() {
    Navigator.pop(context);
  }

  void _datePickerClicked() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 3, now.month, now.day);
    final lastDate = DateTime(now.year + 1, now.month, now.day);

    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: lastDate);

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amoutController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
      child: Column(children: [
        TextField(
          controller: _titleController,
          maxLength: 50,
          decoration: const InputDecoration(
            label: Text(
              "Title",
            ),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _amoutController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  prefixText: "\$",
                  label: Text(
                    "Amount",
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    _selectedDate == null
                        ? "No Selected Date"
                        : formatter.format(_selectedDate!),
                  ),
                  IconButton(
                    onPressed: _datePickerClicked,
                    icon: const Icon(Icons.calendar_month),
                  )
                ],
              ),
            )
          ],
        ),
        const SizedBox(width: 16),
        Row(
          children: [
            DropdownButton(
                value: _selectedCategory,
                items: Category.values
                    .map(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: Text(e.name.toUpperCase()),
                      ),
                    )
                    .toList(),
                onChanged: (currentValue) {
                  if (currentValue != null) {
                    setState(() {
                      _selectedCategory = currentValue;
                    });
                  }
                }),
            const Spacer(),
            TextButton(
              onPressed: _onFormCancelled,
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: _onFormSubmitted,
              child: const Text("Save"),
            )
          ],
        )
      ]),
    );
  }
}
