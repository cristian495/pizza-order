
import 'package:flutter/material.dart';
import 'package:pizzapp/entities/ingredient.dart';
import 'package:pizzapp/widgets/ingredient_item.dart';

class IngredientsList extends StatelessWidget {
  const IngredientsList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: ingredients.length,
      itemBuilder: (context, index) {
        return IngredientItem(
          ingredient: ingredients[index],
        );
      },
    );
  }
}