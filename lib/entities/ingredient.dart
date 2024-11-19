import 'dart:math';

import 'package:flutter/material.dart';

class Ingredient {
  final String image;
  final String imageUnit;
  final List<Offset> positions;

  Ingredient({
    required this.image,
    required this.imageUnit,
    required this.positions,
  });

  bool compare(Ingredient ingredient) {
    return ingredient.image == image;
  }
}

final ingredients = [
  Ingredient(
    image: "assets/mushroom.png",
    imageUnit: "assets/mushroom_unit.png",
    positions: [
      const Offset(0.24, 0.4),
      const Offset(0.6, 0.4),
      const Offset(0.4, 0.25),
      const Offset(0.5, 0.35),
      const Offset(0.4, 0.65),
    ],
  ),
  Ingredient(
    image: "assets/pickle.png",
    imageUnit: "assets/pickle_unit.png",
    positions: [
      const Offset(0.4, 0.35),
      const Offset(0.6, 0.35),
      const Offset(0.3, 0.3),
      const Offset(0.5, 0.25),
      const Offset(0.3, 0.5),
    ],
  ),
  Ingredient(
    image: "assets/pea.png",
    imageUnit: "assets/pea_unit.png",
    positions: [
      const Offset(0.25, 0.5),
      const Offset(0.6, 0.6),
      const Offset(0.3, 0.35),
      const Offset(0.4, 0.2),
      const Offset(0.25, 0.6),
    ],
  ),
  Ingredient(
    image: "assets/potato.png",
    imageUnit: "assets/potato_unit.png",
    positions: [
      const Offset(0.5, 0.25),
      const Offset(0.65, 0.3),
      const Offset(0.25, 0.25),
      const Offset(0.42, 0.35),
      const Offset(0.4, 0.65),
    ],
  ),
  Ingredient(
    image: "assets/chili.png",
    imageUnit: "assets/chili_unit.png",
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
    imageUnit: "assets/garlic.png",
    positions: [
      const Offset(0.4, 0.5),
      const Offset(0.65, 0.3),
      const Offset(0.25, 0.3),
      const Offset(0.6, 0.35),
      const Offset(0.4, 0.64),
    ],
  ),
  Ingredient(
    image: "assets/onion.png",
    imageUnit: "assets/onion.png",
    positions: [
      const Offset(0.65, 0.6),
      const Offset(0.6, 0.2),
      const Offset(0.4, 0.25),
      const Offset(0.5, 0.3),
      const Offset(0.4, 0.65),
    ],
  ),
  Ingredient(
    image: "assets/olive.png",
    imageUnit: "assets/olive_unit.png",
    positions: List.generate(
      5,
      (index) => Offset(
        (Random().nextDouble() * 0.8).clamp(0.24, 0.6),
        (Random().nextDouble() * 0.8).clamp(0.24, 0.6),
      ),
    ),
  ),
];
