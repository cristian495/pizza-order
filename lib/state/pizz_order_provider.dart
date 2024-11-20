import 'package:flutter/material.dart';
import 'package:pizzapp/state/pizza_order_state.dart';

class PizzaOrderProvider extends InheritedWidget {
  final PizzaOrderState state;
  final Widget child;

  const PizzaOrderProvider({
    super.key,
    required this.state,
    required this.child,
  }) : super(child: child);

  static PizzaOrderState of(BuildContext context) {
    return context.findAncestorWidgetOfExactType<PizzaOrderProvider>()!.state;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;
}
