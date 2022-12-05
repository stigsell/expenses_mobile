import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:expenses_mobile/home_page/home_page.dart';
import 'package:expenses_mobile/add_expense/add_expense.dart';
import 'package:expenses_mobile/models/categories.dart';
import 'package:expenses_mobile/models/expenses.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider(create: (context) => CategoriesModel()),
          ChangeNotifierProxyProvider<CategoriesModel, ExpensesModel>(
              create: (context) => ExpensesModel(),
              update: (context, categories, expenses) {
                if (expenses == null) throw ArgumentError.notNull('expenses');
                expenses.categories = categories;
                return expenses;
              })
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.green,
          ),
          initialRoute: '/',
          routes: {
            '/': (context) => const MyHomePage(title: 'Expenses'),
            '/add-expense': (context) => const AddExpense(),
          },
        ));
  }
}
