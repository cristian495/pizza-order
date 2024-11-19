import 'package:flutter/material.dart';
import 'package:pizzapp/entities/ingredient.dart';

class IngredientItem extends StatelessWidget {
  final Ingredient ingredient;
  const IngredientItem({
    required this.ingredient,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final child = Container(
      width: 50,
      height: 50,
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.only(right: 10),
      decoration: const BoxDecoration(
        color: Color(0xfff5eed3),
        shape: BoxShape.circle,
      ),
      child: Image.asset(
        ingredient.image,
        fit: BoxFit.contain,
      ),
    );
    return Center(
      child: Draggable(
        data: ingredient,
        feedback: DecoratedBox(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 50,
                spreadRadius: 1,
                offset: const Offset(-10, 15),
              ),
            ],
          ),
          child: child,
        ),
        child: child,
      ),
    );
  }
}
