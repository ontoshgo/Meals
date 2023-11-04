import 'package:flutter/material.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/category_grid_item.dart';

import '../data/dummy_data.dart';
import '../models/category.dart';
import '../models/meal.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key, required this.meals});

  final List<Meal> meals;

  void _selectCategory(BuildContext context, Category category) {
    final route = MaterialPageRoute(
      builder: (context) => MealsScreen(
        title: category.title,
        meals: meals
            .where((element) => element.categories.contains(category.id))
            .toList(),
      ),
    );
    Navigator.push(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children: availableCategories
          .where((category) {
            return meals.any((meal) => meal.categories.contains(category.id));
          })
          .map((category) => CategoryGridItem(
                category: category,
                onCategorySelected: _selectCategory,
              ))
          .toList(),
    );
  }
}
