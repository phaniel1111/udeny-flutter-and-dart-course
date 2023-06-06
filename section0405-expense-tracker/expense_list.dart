import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({super.key,required this.expenses, required this.onRemoveExpense}) ;
  final List<Expense> expenses;
  final void Function(Expense ep) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, i) => Dismissible(
          background: Container(color: Theme.of(context).colorScheme.error.withOpacity(.75),),
          key: ValueKey( expenses[i]),
          onDismissed: (dic){onRemoveExpense(expenses[i]);},
          child: ExpenseItem(item: expenses[i])),
    );
  }
}

class ExpenseItem extends StatelessWidget {
  const ExpenseItem({super.key,required this.item});
  final Expense item;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          children: [
            Text(item.title),
            const SizedBox(height: 4,),
            Row(
              children: [
                Text('\$ ${item.amount.toStringAsFixed(2)}'),
                const Spacer(),
                Row(
                  children: [
                    Icon(categoryIcons[item.category]),
                    const SizedBox(width: 8,),
                    Text(item.formattedDate),
                  ],
                ),
              ],
            )
          ],
        ),
      ),

    );
  }
}

