import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:expenses_mobile/models/expenses.dart';
import 'package:expenses_mobile/models/categories.dart';

// Define a custom Form widget.
class AddExpenseForm extends StatefulWidget {
  const AddExpenseForm({super.key});

  @override
  AddExpenseFormState createState() {
    return AddExpenseFormState();
  }
}

final categories = CategoriesModel().getAllCategories();

// Define a corresponding State class.
// This class holds data related to the form.
class AddExpenseFormState extends State<AddExpenseForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<AddExpenseFormState>.
  final _formKey = GlobalKey<FormState>();

  final TextEditingController dateController = TextEditingController();
  final TextEditingController placeController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  String categoryDropdownValue = categories.first;

  bool isNumeric(String s) {
    return double.tryParse(s) != null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(labelText: 'Date'),
            controller: dateController,
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a date';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Place'),
            controller: placeController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a place';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Amount'),
            controller: amountController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter an amount';
              }
              if (!isNumeric(value)) {
                return 'Value must be a currency value';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Description'),
            controller: descriptionController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a description';
              }
              return null;
            },
          ),
          DropdownButton(
            value: categoryDropdownValue,
            items: categories.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? value) {
              setState(() {
                categoryDropdownValue = value!;
              });
            },
          ),
          ElevatedButton(
            onPressed: () {
              // Validate returns true if the form is valid, or false otherwise.
              if (_formKey.currentState!.validate()) {
                var expenses = context.read<ExpensesModel>();
                expenses.add(Expense(
                    1,
                    dateController.text,
                    placeController.text,
                    double.parse(amountController.text),
                    descriptionController.text,
                    ExpenseCategory(categoryDropdownValue)));
                Navigator.pop(context); // go back to home page
              }
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
