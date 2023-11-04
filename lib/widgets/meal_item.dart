import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:meals/widgets/meal_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';

import '../models/meal.dart';

class MealItem extends StatelessWidget {
  const MealItem({
    super.key,
    required this.meal,
    required this.onMealTapped,
  });

  final Meal meal;
  final Function(Meal meal) onMealTapped;

  String get complexityText {
    String complexityName = meal.complexity.name;
    return complexityName[0].toUpperCase() +
        complexityName.toLowerCase().substring(1);
  }

  String get affordabilityText {
    String affordabilityName = meal.affordability.name;
    return affordabilityName[0].toUpperCase() +
        affordabilityName.toLowerCase().substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child: InkWell(
        onTap: () {
          onMealTapped(meal);
        },
        child: Stack(
          children: [
            Hero(
              tag: meal.id,
              child: FadeInImage(
                fit: BoxFit.cover,
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(meal.imageUrl),
                height: 200,
                width: double.infinity,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black54,
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 44),
                child: Column(
                  children: [
                    Text(
                      meal.title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MealItemTrait(
                            label: '${meal.duration} min',
                            iconData: Icons.schedule),
                        const SizedBox(
                          width: 12,
                        ),
                        MealItemTrait(
                            label: complexityText, iconData: Icons.work),
                        const SizedBox(
                          width: 12,
                        ),
                        MealItemTrait(
                            label: affordabilityText,
                            iconData: Icons.attach_money)
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
