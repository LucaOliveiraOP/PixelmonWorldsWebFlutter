import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AnimatedButton extends StatefulWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool filled;

  const AnimatedButton({
    super.key,
    required this.label,
    this.onPressed,
    this.filled = true,
  });

  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final bgColor = widget.filled ? Colors.red : Colors.transparent;
    final borderColor = Colors.white;
    final hoverColor = widget.filled ? Colors.red[900]! : Colors.white10;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: _hovering ? hoverColor : bgColor,
            border: Border.all(color: borderColor),
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          child: Text(
            widget.label,
            style: GoogleFonts.pressStart2p(
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                letterSpacing: -0.5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
