import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  @override
  State<StatefulWidget> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  late String currentTitleInputted;

  void _saveTitleInput(String input) {
    currentTitleInputted = input;
  }

  void _onFormSubmitted() {
    print("currentTitleInputted $currentTitleInputted");
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(children: [
        TextField(
          onChanged: _saveTitleInput,
          maxLength: 50,
          decoration: const InputDecoration(
              label: Text(
            "Title",
          )),
        ),
        ElevatedButton(onPressed: _onFormSubmitted, child: const Text("Save"))
      ]),
    );
  }
}
