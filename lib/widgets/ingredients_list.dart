
import 'package:flutter/material.dart';
import 'package:pizzapp/entities/ingredient.dart';
import 'package:pizzapp/state/pizz_order_provider.dart';
import 'package:pizzapp/widgets/ingredient_item.dart';

class IngredientsList extends StatelessWidget {
  const IngredientsList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final state = PizzaOrderProvider.of(context);

    return ValueListenableBuilder<int>(
      valueListenable: state.notifierTotalPrice,
      builder: (context, totalPrice, _) => ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: ingredients.length,
        itemBuilder: (context, index) {
          return IngredientItem(
            ingredient: ingredients[index],
            selected: !state.containsIngredient(ingredients[index]),
            onTap: () {
              state.removeIngredient(ingredients[index]);
            },
          );
        },
      ),
    );
  }
}