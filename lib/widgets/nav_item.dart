import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NavItem extends StatefulWidget {
  final String label;
  final IconData icon;

  const NavItem({
    super.key,
    required this.label,
    required this.icon,
  });

  @override
  State<NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<NavItem> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final hoverColor = Colors.red[700]!;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedDefaultTextStyle(
        duration: const Duration(milliseconds: 200),
        style: TextStyle(
          color: _hovering ? hoverColor : Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w500,
          fontFamily: GoogleFonts.pressStart2p().fontFamily,
        ),
        child: Row(
          children: [
            Icon(
              widget.icon,
              color: _hovering ? hoverColor : Colors.white,
              size: 18,
            ),
            const SizedBox(width: 4),
            Text(widget.label),
            const SizedBox(width: 12),
          ],
        ),
      ),
    );
  }
}
