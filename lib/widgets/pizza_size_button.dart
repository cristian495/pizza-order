import 'package:flutter/material.dart';

class PizzaSizeButton extends StatelessWidget {
  final bool selected;
  final VoidCallback onTap;
  final String text;

  const PizzaSizeButton({
    required this.selected,
    required this.onTap,
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: selected
                ? [
                    const BoxShadow(
                      spreadRadius: 1,
                      color: Colors.black12,
                      offset: Offset(0, 10),
                      blurRadius: 20,
                    ),
                  ]
                : null,
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 18,
                color: Colors.brown,
                fontWeight: selected ? FontWeight.bold : FontWeight.w300,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
