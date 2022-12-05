import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:expenses_mobile/models/expenses.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _ExpensesList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/add-expense'),
        tooltip: 'Add expense',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class _ExpensesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var itemNameStyle = Theme.of(context).textTheme.titleLarge;
    var expenses = context.watch<ExpensesModel>();

    return ListView.builder(
      itemCount: expenses.expenses.length,
      itemBuilder: (context, index) => ListTile(
        trailing: IconButton(
          icon: const Icon(Icons.remove_circle_outline),
          onPressed: () {
            expenses.remove(expenses.expenses[index]);
          },
        ),
        title: Text(
          '${expenses.expenses[index].date}  ${expenses.expenses[index].place}   \$${expenses.expenses[index].amount.toStringAsFixed(2)} (${expenses.expenses[index].category})',
          style: itemNameStyle,
        ),
        subtitle: Text(
          expenses.expenses[index].description,
        ),
        isThreeLine: true,
      ),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
    );
  }
}
