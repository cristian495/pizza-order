import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pizzapp/entities/ingredient.dart';
import 'package:pizzapp/entities/pizza_size.dart';
import 'package:pizzapp/state/pizza_size_state.dart';
import 'package:pizzapp/widgets/pizza_size_button.dart';

class PizzaPreview extends StatefulWidget {
  const PizzaPreview({
    super.key,
  });

  @override
  State<PizzaPreview> createState() => _PizzaPreviewState();
}

class _PizzaPreviewState extends State<PizzaPreview>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _animationRotationController;
  final List<Ingredient> _selectedIngredients = [];
  bool _isDishHover = false;
  int _totalPrice = 15;
  final List<Animation> _animations = [];
  BoxConstraints _pizzaConstraints = BoxConstraints();
  final _notifierPizzaSize =
      ValueNotifier<PizzaSizeState>(PizzaSizeState(PizzaSizeValue.m));

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _animationRotationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _buildIngredientsAnimations();
    });
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _animationRotationController.dispose();
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
          flex: 5,
          child: Container(
            // color: Colors.purple,
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
                return ValueListenableBuilder<PizzaSizeState>(
                    valueListenable: _notifierPizzaSize,
                    builder: (context, pizzaSize, _) {
                      return RotationTransition(
                        turns: CurvedAnimation(
                          parent: _animationRotationController,
                          curve: Curves.easeOut,
                        ),
                        child: Stack(
                          children: [
                            LayoutBuilder(builder: (_, constraints) {
                              _pizzaConstraints = constraints;
                              return Center(
                                child: AnimatedContainer(
                                  // color: Colors.green,
                                  height: _isDishHover
                                      ? constraints.maxHeight * pizzaSize.factor
                                      : constraints.maxHeight *
                                              pizzaSize.factor -
                                          15,
                                  duration: const Duration(milliseconds: 300),
                                  child: Stack(
                                    children: [
                                      DecoratedBox(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 20,
                                              color:
                                                  Colors.brown.withOpacity(0.5),
                                              offset: const Offset(0, 20),
                                              spreadRadius: -8,
                                            ),
                                          ],
                                        ),
                                        child: Image.asset('assets/dish.png'),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child:
                                            Image.asset('assets/pizza-1.png'),
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
                        ),
                      );
                    });
              },
            ),
          ),
        ),
        Expanded(
          child: Container(
            // color: Colors.blue,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (child, animation) {
                    return SlideTransition(
                      position: animation.drive(
                        Tween<Offset>(
                          begin: const Offset(0.0, 1.0),
                          end: const Offset(0.0, 0.1),
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
                ),
              ],
            ),
          ),
        ),
        ValueListenableBuilder<PizzaSizeState>(
            valueListenable: _notifierPizzaSize,
            builder: (context, pizzaSize, _) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PizzaSizeButton(
                    text: "S",
                    selected: pizzaSize.value == PizzaSizeValue.s,
                    onTap: () {
                      _updatePizzaSize(PizzaSizeValue.s);
                    },
                  ),
                  PizzaSizeButton(
                    text: "M",
                    selected: pizzaSize.value == PizzaSizeValue.m,
                    onTap: () {
                      _updatePizzaSize(PizzaSizeValue.m);
                    },
                  ),
                  PizzaSizeButton(
                    text: "L",
                    selected: pizzaSize.value == PizzaSizeValue.l,
                    onTap: () {
                      _updatePizzaSize(PizzaSizeValue.l);
                    },
                  ),
                ],
              );
            })
      ],
    );
  }

  void _updatePizzaSize(PizzaSizeValue value) {
    _notifierPizzaSize.value = PizzaSizeState(value);
    _animationRotationController.forward(from: 0.0);
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
                  child: Column(
                    children: [
                      Image.asset(
                        ingredient.imageUnit,
                        width: 50,
                        height: 50,
                      ),
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.brown,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          j.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
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
              child: Column(
                children: [
                  Image.asset(
                    ingredient.imageUnit,
                    width: 50,
                    height: 50,
                  ),
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.brown,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      j.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
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
