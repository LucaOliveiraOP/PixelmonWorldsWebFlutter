import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SectionContainer extends StatefulWidget {
  final String title;
  final String content;
  final IconData? icon;

  const SectionContainer({
    super.key,
    required this.title,
    required this.content,
    this.icon,
  });

  @override
  State<SectionContainer> createState() => _SectionContainerState();
}

class _SectionContainerState extends State<SectionContainer> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final borderColor = _hovering ? Colors.red : Colors.white24;
    final iconColor = _hovering ? Colors.red : Colors.white;
    final titleColor = _hovering ? Colors.red : Colors.white;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 480,
        constraints: const BoxConstraints(minHeight: 280),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor, width: 1.5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.icon != null) ...[
              Icon(widget.icon, size: 48, color: iconColor),
              const SizedBox(height: 16),
            ],
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: GoogleFonts.pressStart2p(
                textStyle: TextStyle(
                  color: titleColor,
                  fontSize: 14,
                  letterSpacing: -1,
                  height: 1.2,
                ),
              ),
              child: Text(
                widget.title,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              widget.content,
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.pressStart2p(
                textStyle: const TextStyle(
                  color: Colors.white70,
                  fontSize: 10,
                  letterSpacing: -0.5,
                  height: 1.4,
                ),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
