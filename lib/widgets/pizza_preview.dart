import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pizzapp/entities/ingredient.dart';
import 'package:pizzapp/entities/pizza_size.dart';
import 'package:pizzapp/state/pizz_order_provider.dart';
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
  // final List<Ingredient> _selectedIngredients = [];
  // bool _isDishHover = false;
  // int _totalPrice = 15;
  final List<Animation> _animations = [];
  BoxConstraints _pizzaConstraints = BoxConstraints();
  final _notifierPizzaSize =
      ValueNotifier<PizzaSizeState>(PizzaSizeState(PizzaSizeValue.m));
  final _notifierIsDishHover = ValueNotifier<bool>(false);

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
    final state = PizzaOrderProvider.of(context);
    return Column(
      children: [
        Expanded(
          flex: 5,
          child: Container(
            // color: Colors.purple,
            child: DragTarget<Ingredient>(
              onAcceptWithDetails: (element) {
                _notifierIsDishHover.value = false;
                state.addIngredient(element.data);
                // setState(() {
                // _isDishHover = false;
                // _selectedIngredients.add(element.data);
                // _totalPrice += 2;
                // });
                // _buildIngredientsAnimations();
                _animationController.forward(from: 0.0);
              },
              onWillAcceptWithDetails: (element) {
                _notifierIsDishHover.value = true;
                // setState(() {
                //   _isDishHover = true;
                // });
                return state.containsIngredient(element.data);
                // for (final ingredient in _selectedIngredients) {
                //   if (ingredient.compare(element.data)) {
                //     return false;
                //   }
                // }

                // return true;
              },
              onLeave: (data) {
                _notifierIsDishHover.value = false;
                // setState(() {
                //   _isDishHover = false;
                // });
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
                            ValueListenableBuilder<bool>(
                                valueListenable: _notifierIsDishHover,
                                builder: (context, isDishHover, _) {
                                  return LayoutBuilder(
                                      builder: (_, constraints) {
                                    _pizzaConstraints = constraints;
                                    return Center(
                                      child: AnimatedContainer(
                                        // color: Colors.green,
                                        height: isDishHover
                                            ? constraints.maxHeight *
                                                pizzaSize.factor
                                            : constraints.maxHeight *
                                                    pizzaSize.factor -
                                                15,
                                        duration:
                                            const Duration(milliseconds: 300),
                                        child: Stack(
                                          children: [
                                            DecoratedBox(
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                boxShadow: [
                                                  BoxShadow(
                                                    blurRadius: 20,
                                                    color: Colors.brown
                                                        .withOpacity(0.5),
                                                    offset: const Offset(0, 20),
                                                    spreadRadius: -8,
                                                  ),
                                                ],
                                              ),
                                              child: Image.asset(
                                                  'assets/dish.png'),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(16.0),
                                              child: Image.asset(
                                                  'assets/pizza-1.png'),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                                }),
                            Positioned.fill(
                              child: ValueListenableBuilder<Ingredient?>(
                                  valueListenable:
                                      state.notifierDeletedIngredient,
                                  builder: (context, deletedIngredient, _) {
                                    _animateDeletedIngredient(
                                      deletedIngredient,
                                    );
                                    return Container(
                                      // color: Colors.red,
                                      child: AnimatedBuilder(
                                        animation: _animationController,
                                        builder: (context, _) {
                                          return _buildIngredientsWidget(
                                              deletedIngredient);
                                        },
                                      ),
                                    );
                                  }),
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
          child: ValueListenableBuilder<int>(
              valueListenable: state.notifierTotalPrice,
              builder: (context, totalPrice, _) {
                return Container(
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
                          "\$${totalPrice}",
                          key: ValueKey(totalPrice),
                          style: const TextStyle(
                            color: Colors.brown,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
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

  Widget _buildIngredientsWidget(deletedIngredient) {
    List<Widget> children = [];
    final selectedIngredients = List.from(PizzaOrderProvider.of(
      context,
    ).selectedIngredients);

    if (deletedIngredient != null) {
      selectedIngredients.add(deletedIngredient);
    }

    if (selectedIngredients.isEmpty) {
      return const SizedBox();
    }
    for (var i = 0; i < selectedIngredients.length; i++) {
      Ingredient ingredient = selectedIngredients[i];

      for (var j = 0; j < ingredient.positions.length; j++) {
        final animation = _animations[j];
        final position = ingredient.positions[j];
        final positionX = position.dx;
        final positionY = position.dy;
        double fromX = 0.0, fromY = 0.0;

        if (i == selectedIngredients.length - 1 &&
            _animationController.isAnimating) {
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

  Future<void> _animateDeletedIngredient(Ingredient? deletedIngredient) async {
    if (deletedIngredient != null) {
      await _animationController.reverse(from: 1);
      final state = PizzaOrderProvider.of(context);
      state.refreshDeletedIngredient();
    }
  }
}
