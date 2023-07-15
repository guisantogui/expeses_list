import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

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
    print(
        "currentTitleInputted ${_titleController.text} amount ${_amoutController.text}");
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
      padding: EdgeInsets.all(16),
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
