import 'package:flutter/material.dart';

class NavItem extends StatefulWidget {
  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback? ontap;

  const NavItem({
    super.key,
    required this.label,
    required this.icon,
    required this.selected,
    this.ontap,
  });

  @override
  State<NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<NavItem> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final baseColor = Colors.white;
    final hoverColor = Colors.red[700]!;
    final selectedColor = Colors.redAccent;

    final color =
        widget.selected ? selectedColor : (_hovering ? hoverColor : baseColor);

    return GestureDetector(
      onTap: widget.ontap,
      child: MouseRegion(
        onEnter: (_) => setState(() => _hovering = true),
        onExit: (_) => setState(() => _hovering = false),
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 200),
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 10,
                letterSpacing: 0,
                color: color,
                fontWeight:
                    widget.selected ? FontWeight.bold : FontWeight.normal,
              ),
          child: Row(
            children: [
              Icon(
                widget.icon,
                color: color,
                size: 18,
              ),
              const SizedBox(width: 6),
              Text(widget.label),
              const SizedBox(width: 6),
            ],
          ),
        ),
      ),
    );
  }
}
