import 'package:flutter/material.dart';

// The categories that an expense can be
class CategoriesModel {
  static List<String> categories = [
    'Alcohol',
    'Cat',
    'Clothing',
    'Donation',
    'Entertainment',
    'Fitness',
    'Food/Drink',
    'Gift',
    'Groceries',
    'Misc',
    'Rent',
    'Services',
    'Transportation',
    'Travel',
    'Utilities'
  ];

  ExpenseCategory getByName(String name) {
    // return categories.firstWhere((category) => category.name === name);
    return ExpenseCategory(name);
  }

  List<String> getAllCategories() {
    return categories;
  }
}

@immutable
class ExpenseCategory {
  final String name;

  const ExpenseCategory(this.name);

  // @override
  // int get hashCode => id;

  // @override
  // bool operator ==(Object other) => other is ExpenseCategory && other.id == id;

  @override
  String toString() {
    return name;
  }
}
