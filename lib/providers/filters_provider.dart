import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/meals_provider.dart';

import '../models/meal.dart';

const kInitialFilters = {
  Filters.lactoseFree: false,
  Filters.glutenFree: false,
  Filters.vegetarian: false,
  Filters.vegan: false,
};

enum Filters {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class FiltersNotifier extends StateNotifier<Map<Filters, bool>> {
  FiltersNotifier() : super(kInitialFilters);

  void setFilterValue(Filters key, bool value) {
    state = {
      ...state,
      key: value,
    };
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filters, bool>>(
        (ref) => FiltersNotifier());

final filteredMealsProvider = Provider<List<Meal>>((ref) {
  final meals = ref.watch(mealsProvider);
  final activeFilters = ref.watch(filtersProvider);
  final availableMeals = meals.where((meal) {
    if (activeFilters[Filters.glutenFree] == true && !meal.isGlutenFree) {
      return false;
    }
    if (activeFilters[Filters.lactoseFree] == true && !meal.isLactoseFree) {
      return false;
    }
    if (activeFilters[Filters.vegetarian] == true && !meal.isVegetarian) {
      return false;
    }
    if (activeFilters[Filters.vegan] == true && !meal.isVegan) {
      return false;
    }
    return true;
  }).toList();
  return availableMeals;
});
