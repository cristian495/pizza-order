import 'package:flutter/material.dart';
import 'package:pizzapp/widgets/ingredients_list.dart';
import 'package:pizzapp/widgets/pizza_preview.dart';
import 'package:pizzapp/widgets/add_to_card_button.dart';

const addToCardButtonSize = 50.0;

class PizzaDetail extends StatelessWidget {
  const PizzaDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'New Orleans Pizza',
          style: TextStyle(color: Colors.brown),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios, size: 25, color: Colors.brown),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.shopping_cart_checkout,
              size: 30,
              color: Colors.brown,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            left: 10,
            right: 10,
            top: 10,
            bottom: 50,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 5,
              child: Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      // color: Colors.red,
                      child: PizzaPreview(),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      // color: Colors.green,
                      child: IngredientsList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: addToCardButtonSize / 2 + 5,
            height: addToCardButtonSize,
            width: addToCardButtonSize,
            left:
                MediaQuery.of(context).size.width / 2 - addToCardButtonSize / 2,
            child: AddToCartButton(
              onPressed: () {},
            ),
          )
        ],
      ),
    );
  }
}
