import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealapp/model/mealdetails.dart';

class FavoriteMealsNotifiers extends StateNotifier<List<Meal>> {
  FavoriteMealsNotifiers(super.state);

  bool toggleMealFavoriteStatus(Meal meal) {
    final mealsFavorites = state.contains(meal);
    if (mealsFavorites) {
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

final favoriteMealsProvider =
    StateNotifierProvider<FavoriteMealsNotifiers, List<Meal>>((ref) {
  return FavoriteMealsNotifiers([]);
});
