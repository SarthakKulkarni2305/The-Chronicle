import 'package:flutter/material.dart';

class LogoAndWelcomedMessage extends StatelessWidget {
  const LogoAndWelcomedMessage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // logo
        const Icon(
          Icons.lock,
          size: 100,
        ),

        const SizedBox(height: 50),

        // welcome back, you've been missed!
        Text(
          'Welcome back you\'ve been missed!',
          style: TextStyle(
            color: Colors.grey[700],
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
