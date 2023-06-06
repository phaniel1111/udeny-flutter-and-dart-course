import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:meals/screens/meal_details.dart';
class MealItem extends StatelessWidget {
  const MealItem({super.key, required this.meal, required this.onToggleFavoriteMeals});
  final Meal meal;
  final void Function(Meal meal) onToggleFavoriteMeals;

  @override
  Widget build(BuildContext context) {
    final TextStyle textTheme = Theme.of(context).textTheme.titleLarge!.copyWith(
      color: Theme.of(context).colorScheme.onBackground,
      fontWeight: FontWeight.bold,
    );
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child: InkWell(
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MealDetailScreen(meal: meal, onToggleFavoriteMeals: onToggleFavoriteMeals,)),);
          },
        child: Stack(
          children: [
            FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(meal.imageUrl),
              fit: BoxFit.cover,
              height: 200,
              width: double.infinity,
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                color: Colors.black54,
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                child: Column(
                  children: [
                    Text(
                      meal.title,
                      maxLines: 2,
                      style: textTheme,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 12,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MealItemTrait(icon: Icons.schedule,label: "${meal.duration} min",),
                        const SizedBox(width: 12,),
                        MealItemTrait(icon: Icons.work,label: meal.complexityText,),
                        const SizedBox(width: 12,),
                        MealItemTrait(icon: Icons.attach_money,label: meal.affordabilityText,),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MealItemTrait extends StatelessWidget {
  const MealItemTrait({super.key, required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 17, color: Colors.white,),
        const SizedBox(width: 6,),
        Text(label, style: const TextStyle(color: Colors.white)),
      ],
    );
  }
}
