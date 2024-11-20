import 'package:flutter/material.dart';
import 'package:pizzapp/entities/ingredient.dart';

class PizzaOrderState extends ChangeNotifier {
  List<Ingredient> selectedIngredients = [];
  final notifierTotalPrice = ValueNotifier<int>(15);
  final notifierDeletedIngredient = ValueNotifier<Ingredient?>(null);

  void addIngredient(Ingredient ingredient) {
    selectedIngredients.add(ingredient);
    notifierTotalPrice.value += 2;
    // notifyListeners();
  }

  bool containsIngredient(Ingredient ingredient) {
    for (final e in selectedIngredients) {
      if (e.compare(ingredient)) {
        return false;
      }
    }
    return true;
  }

  void removeIngredient(Ingredient ingredient) {
    selectedIngredients.remove(ingredient);
    notifierTotalPrice.value -= 2;
    notifierDeletedIngredient.value = ingredient;
    // notifyListeners();
  }

  void refreshDeletedIngredient() {
    notifierDeletedIngredient.value = null;
  }
}
