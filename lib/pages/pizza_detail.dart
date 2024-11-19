import 'package:flutter/material.dart';
import 'package:pizzapp/entities/ingredient.dart';

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
              child: const Column(
                children: [
                  Expanded(child: PizzaPreview()),
                  Expanded(
                    child: IngredientsList(),
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

class AddToCartButton extends StatefulWidget {
  final VoidCallback onPressed;
  const AddToCartButton({
    required this.onPressed,
    super.key,
  });

  @override
  State<AddToCartButton> createState() => _AddToCartButtonState();
}

class _AddToCartButtonState extends State<AddToCartButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
      reverseDuration: const Duration(milliseconds: 150),
      lowerBound: 1,
      upperBound: 1.5,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onPressed.call();
        _animationController.forward(from: 0.0);
        _animateButton();
      },
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Transform.scale(
            scale: (1.5 - _animationController.value),
            child: child!,
          );
        },
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(13),
            decoration: BoxDecoration(
              color: Colors.orange,
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color.fromARGB(255, 243, 201, 137), Colors.orange],
              ),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.orange.withOpacity(0.5),
                  blurRadius: 5,
                  spreadRadius: 1,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: const Icon(
              Icons.shopping_cart_outlined,
              color: Colors.white,
              size: 25,
            ),
          ),
        ),
      ),
    );
  }

  void _animateButton() async {
    await _animationController.forward(from: 0.0);
    await _animationController.reverse();
  }
}

class PizzaPreview extends StatefulWidget {
  const PizzaPreview({
    super.key,
  });

  @override
  State<PizzaPreview> createState() => _PizzaPreviewState();
}

class _PizzaPreviewState extends State<PizzaPreview>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  final List<Ingredient> _selectedIngredients = [];
  bool _isDishHover = false;
  int _totalPrice = 15;
  final List<Animation> _animations = [];
  BoxConstraints _pizzaConstraints = BoxConstraints();

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _buildIngredientsAnimations();
    });
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _buildIngredientsAnimations() {
    _animations.clear();
    _animations.add(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.2, curve: Curves.decelerate),
      ),
    );
    _animations.add(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.2, 0.8, curve: Curves.decelerate),
      ),
    );
    _animations.add(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.4, 1.0, curve: Curves.decelerate),
      ),
    );
    _animations.add(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.1, 0.7, curve: Curves.decelerate),
      ),
    );
    _animations.add(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.3, 1.0, curve: Curves.decelerate),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 7,
          child: DragTarget<Ingredient>(
            onAcceptWithDetails: (element) {
              setState(() {
                _isDishHover = false;
                _selectedIngredients.add(element.data);
                _totalPrice += 2;
              });
              // _buildIngredientsAnimations();
              _animationController.forward(from: 0.0);
            },
            onWillAcceptWithDetails: (element) {
              setState(() {
                _isDishHover = true;
              });

              for (final ingredient in _selectedIngredients) {
                if (ingredient.compare(element.data)) {
                  return false;
                }
              }

              return true;
            },
            onLeave: (data) {
              setState(() {
                _isDishHover = false;
              });
              debugPrint('Left');
            },
            builder: (context, candidateData, rejectedData) {
              return Stack(
                children: [
                  LayoutBuilder(builder: (_, constraints) {
                    _pizzaConstraints = constraints;
                    return Center(
                      child: AnimatedContainer(
                        // color: Colors.green,
                        height: _isDishHover
                            ? constraints.maxHeight
                            : constraints.maxHeight - 15,
                        duration: const Duration(milliseconds: 300),
                        child: Stack(
                          children: [
                            Image.asset('assets/dish.png'),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Image.asset('assets/pizza-1.png'),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                  Positioned.fill(
                    child: Container(
                      // color: Colors.red,
                      child: AnimatedBuilder(
                        animation: _animationController,
                        builder: (context, _) {
                          return _buildIngredientsWidget();
                        },
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) {
            return SlideTransition(
              position: animation.drive(
                Tween<Offset>(
                  begin: const Offset(0.0, 1.0),
                  end: const Offset(0.0, 0.7),
                ),
              ),
              child: child,
            );
          },
          child: Text(
            "\$$_totalPrice",
            key: ValueKey(_totalPrice),
            style: const TextStyle(
              color: Colors.brown,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }

  Widget _buildIngredientsWidget() {
    List<Widget> children = [];
    if (_selectedIngredients.isEmpty) {
      return const SizedBox();
    }
    for (var i = 0; i < _selectedIngredients.length; i++) {
      Ingredient ingredient = _selectedIngredients[i];

      for (var j = 0; j < ingredient.positions.length; j++) {
        final animation = _animations[j];
        final position = ingredient.positions[j];
        final positionX = position.dx;
        final positionY = position.dy;
        double fromX = 0.0, fromY = 0.0;

        if (i == _selectedIngredients.length - 1) {
          if (j < 1) {
            fromX = _pizzaConstraints.maxWidth * (1 - animation.value);
          } else if (j < 2) {
            fromX = _pizzaConstraints.maxWidth * (1 - animation.value);
          } else if (j < 3) {
            fromY = _pizzaConstraints.maxHeight * (1 - animation.value);
          } else if (j < 4) {
            fromY = _pizzaConstraints.maxHeight * (1 - animation.value);
          }

          if (animation.value > 0) {
            children.add(
              Opacity(
                opacity: animation.value,
                child: Transform(
                  transform: Matrix4.identity()
                    ..translate(
                      fromX + _pizzaConstraints.maxWidth * positionX,
                      fromY + _pizzaConstraints.maxHeight * positionY,
                    ),
                  child: Image.asset(
                    ingredient.image,
                    width: 50,
                    height: 50,
                  ),
                ),
              ),
            );
          }
        } else {
          children.add(
            Transform(
              transform: Matrix4.identity()
                ..translate(
                  _pizzaConstraints.maxWidth * positionX,
                  _pizzaConstraints.maxHeight * positionY,
                ),
              child: Image.asset(
                ingredient.image,
                width: 50,
                height: 50,
              ),
            ),
          );
        }
      }
    }

    return Stack(
      children: children,
    );
  }
}
