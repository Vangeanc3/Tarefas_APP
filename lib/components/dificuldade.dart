import 'package:flutter/material.dart';

class Dificuldade extends StatelessWidget {
  final int dificuldadeLevel;

  const Dificuldade({
    required this.dificuldadeLevel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.star,
          color: (dificuldadeLevel >= 1) ? Colors.blue : Colors.blue[100],
          size: 16,
        ),
        Icon(
          Icons.star,
          color: (dificuldadeLevel >= 2) ? Colors.blue : Colors.blue[100],
          size: 16,
        ),
        Icon(
          Icons.star,
          color: (dificuldadeLevel >= 3) ? Colors.blue : Colors.blue[100],
          size: 16,
        ),
        Icon(
          Icons.star,
          color: (dificuldadeLevel >= 4) ? Colors.blue : Colors.blue[100],
          size: 16,
        ),
        Icon(
          Icons.star,
          color: (dificuldadeLevel >= 5) ? Colors.blue : Colors.blue[100],
          size: 16,
        ),
      ],
    );
  }
}
