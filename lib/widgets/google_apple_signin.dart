import 'package:aym_news/widgets/square_tile.dart';
import 'package:flutter/material.dart';

class GoogleAndAppleSignIn extends StatelessWidget {
  const GoogleAndAppleSignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // google button
        SquareTile(imagePath: 'assets/google.png'),

        SizedBox(width: 25),

        // apple button
        SquareTile(imagePath: 'assets/apple.png')
      ],
    );
  }
}
