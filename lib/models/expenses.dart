import 'package:flutter/foundation.dart';
import 'package:expenses_mobile/models/categories.dart';

class ExpensesModel extends ChangeNotifier {
  /// The private field backing [categories].
  late CategoriesModel _categories;

  /// Internal, private state of expenses.
  final List<Expense> _expenses = [];

  /// The current categories.
  CategoriesModel get categories => _categories;

  set categories(CategoriesModel newCategories) {
    _categories = newCategories;
    // Notify listeners, in case the new categories provides information
    // different from the previous one.
    notifyListeners();
  }

  /// List of expenses.
  List<Expense> get expenses => _expenses;

  /// Adds [expense] to expenses. This is the only way to modify expenses from outside.
  void add(Expense expense) {
    _expenses.add(expense);
    notifyListeners();
  }

  void remove(Expense expense) {
    _expenses.remove(expense);
    notifyListeners();
  }
}

@immutable
class Expense {
  final int id;
  final String date;
  final String place;
  final double amount;
  final String description;
  final ExpenseCategory category;

  const Expense(this.id, this.date, this.place, this.amount, this.description,
      this.category);

  @override
  int get hashCode => id;

  @override
  bool operator ==(Object other) => other is Expense && other.id == id;
}
