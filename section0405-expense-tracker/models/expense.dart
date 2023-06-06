import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
//import 'package:intl/intl';

final formatter = DateFormat('dd/MM/yyyy');

const uuid = Uuid();

enum Category {food, travel, pleasure, work}

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.pleasure: Icons.videogame_asset,
  Category.work: Icons.work,
};

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formattedDate{
    return formatter.format(date);
  }
}

class ExpenseBucket{
  const ExpenseBucket({required this.category, required this.expenses} );

  ExpenseBucket.forCategory(final List<Expense> allExpenses, this.category)
      : expenses = allExpenses.where((e) => e.category == category).toList();

  final Category category;
  final List<Expense> expenses;

  double get totalExpenses{
    double sum=0;
    for(final i in expenses){
      sum += i.amount;
    }
    return sum;
  }
}