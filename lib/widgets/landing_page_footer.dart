import 'package:flutter/material.dart';

class LandingPageFooter extends StatelessWidget {
  const LandingPageFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black87,
      padding: const EdgeInsets.all(32),
      child: const Center(
        child: Text(
          '© 2025 Pixelmon Worlds. Todos os direitos reservados.',
          style: TextStyle(color: Colors.white70),
        ),
      ),
    );
  }
}
