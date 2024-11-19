import 'package:flutter/material.dart';

class Ingredient {
  final String image;
  final List<Offset> positions;

  Ingredient({
    required this.image,
    required this.positions,
  });

  bool compare(Ingredient ingredient) {
    return ingredient.image == image;
  }
}

final ingredients = [
  Ingredient(
    image: "assets/mushroom_unit.png",
    positions: [
      const Offset(0.2, 0.2),
      const Offset(0.6, 0.2),
      const Offset(0.4, 0.25),
      const Offset(0.5, 0.0),
      const Offset(0.4, 0.65),
    ],
  ),
  Ingredient(
    image: "assets/pickle_unit.png",
    positions: [
      const Offset(0.2, 0.35),
      const Offset(0.65, 0.35),
      const Offset(0.3, 0.23),
      const Offset(0.5, 0.2),
      const Offset(0.3, 0.5),
    ],
  ),
  Ingredient(
    image: "assets/pea_unit.png",
    positions: [
      const Offset(0.25, 0.5),
      const Offset(0.65, 0.6),
      const Offset(0.2, 0.3),
      const Offset(0.4, 0.2),
      const Offset(0.2, 0.6),
    ],
  ),
  Ingredient(
    image: "assets/potato.png",
    positions: [
      const Offset(0.2, 0.65),
      const Offset(0.65, 0.3),
      const Offset(0.25, 0.25),
      const Offset(0.45, 0.35),
      const Offset(0.4, 0.65),
    ],
  ),
  Ingredient(
    image: "assets/chili.png",
    positions: [
      const Offset(0.2, 0.35),
      const Offset(0.65, 0.35),
      const Offset(0.3, 0.23),
      const Offset(0.5, 0.2),
      const Offset(0.3, 0.5),
    ],
  ),
  Ingredient(
    image: "assets/garlic.png",
    positions: [
      const Offset(0.2, 0.65),
      const Offset(0.65, 0.3),
      const Offset(0.25, 0.24),
      const Offset(0.45, 0.35),
      const Offset(0.4, 0.64),
    ],
  ),
  Ingredient(
    image: "assets/onion.png",
    positions: [
      const Offset(0.2, 0.2),
      const Offset(0.6, 0.2),
      const Offset(0.4, 0.25),
      const Offset(0.5, 0.3),
      const Offset(0.4, 0.65),
    ],
  ),
  Ingredient(
    image: "assets/olive.png",
    positions: List.generate(5, (index) => Offset(0.2 + index * 0.1, 0.5)),
  ),
];
