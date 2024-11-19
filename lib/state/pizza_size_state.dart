
import 'package:pizzapp/entities/pizza_size.dart';

class PizzaSizeState {
  static Map<PizzaSizeValue, double> factorDictionary = {
    PizzaSizeValue.s: 0.75,
  PizzaSizeValue.m: 0.85,
    PizzaSizeValue.l: 1.0,
  };
  final PizzaSizeValue value;
  double factor;

  PizzaSizeState(this.value) : factor = factorDictionary[value] ?? 1.0;
}