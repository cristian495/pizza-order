import 'package:flutter/material.dart';
import 'package:pizzapp/entities/ingredient.dart';
import 'package:pizzapp/state/pizz_order_provider.dart';

class IngredientItem extends StatelessWidget {
  final Ingredient ingredient;
  final bool selected;
  final VoidCallback? onTap;
  const IngredientItem({
    required this.ingredient,
    this.selected = false,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final child = GestureDetector(
      onTap: selected ? onTap : null,
      child: Container(
        width: 50,
        height: 50,
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          color: const Color(0xfff5eed3),
          shape: BoxShape.circle,
          border: selected
              ? Border.all(
                  color: Colors.brown,
                  width: 2,
                )
              : null,
        ),
        child: Image.asset(
          ingredient.image,
          fit: BoxFit.contain,
        ),
      ),
    );
    return Center(
      child: selected
          ? child
          : Draggable(
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
