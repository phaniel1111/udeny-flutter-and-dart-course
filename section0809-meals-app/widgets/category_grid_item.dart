import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/category.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/meals.dart';

class CategoryGridItem extends StatelessWidget {
  const CategoryGridItem({super.key, required this.category, required this.onToggleFavoriteMeals});
  final void Function(Meal meal) onToggleFavoriteMeals;

  final Category category;

  filterCategory(List<Meal> dummyMeals){
    return dummyMeals.where((meal) => meal.categories.contains(category.id)).toList();
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MealsScreen(title: category.title, meals: filterCategory(dummyMeals), onToggleFavoriteMeals: onToggleFavoriteMeals,)),
      ); },
      borderRadius: BorderRadius.circular(16),
      splashColor: Theme.of(context).primaryColorLight,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              category.color.withOpacity(0.5),
              category.color.withOpacity(0.9),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Text(
          category.title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
      ),
    );
  }
}
