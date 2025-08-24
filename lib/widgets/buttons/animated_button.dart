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
    final isFilled = widget.filled;

    final backgroundDecoration = isFilled
        ? BoxDecoration(
            gradient: LinearGradient(
              colors: _hovering
                  ? [Color(0xFFFBC570), Color(0xFFBA0F0A)]
                  : [Color(0xFFBA0F0A), Color(0xFFFBC570)],
            ),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white),
          )
        : BoxDecoration(
            color: _hovering ? Colors.white10 : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white),
          );

    final textColor = isFilled ? Colors.white : Colors.white;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: backgroundDecoration,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          child: Text(
            widget.label,
            style: GoogleFonts.pressStart2p(
              textStyle: TextStyle(
                color: textColor,
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
