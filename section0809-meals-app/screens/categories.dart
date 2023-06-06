import 'package:flutter/material.dart';
import 'package:meals/widgets/category_grid_item.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/meal.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen ({super.key, required this.onToggleFavoriteMeals});
  final void Function(Meal meal) onToggleFavoriteMeals;

  @override
  Widget build(BuildContext context) {
    return GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.5,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20
        ),
        children: [
          for (final i in availableCategories)
            CategoryGridItem(category: i,onToggleFavoriteMeals: onToggleFavoriteMeals,),
        ],
    );
  }
}
