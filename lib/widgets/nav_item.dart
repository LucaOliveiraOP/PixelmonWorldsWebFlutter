import 'package:flutter/material.dart';

class NavItem extends StatefulWidget {
  final String label;
  final IconData icon;
  final VoidCallback? ontap;

  const NavItem({
    super.key,
    required this.label,
    required this.icon,
    this.ontap,
  });

  @override
  State<NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<NavItem> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final hoverColor = Colors.red[700]!;

    return GestureDetector(
      onTap: widget.ontap,
      child: MouseRegion(
        onEnter: (_) => setState(() => _hovering = true),
        onExit: (_) => setState(() => _hovering = false),
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 200),
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                fontSize: 12,
                letterSpacing: -1,
                height: 1.2,
                color: _hovering ? hoverColor : Colors.white,
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
      ),
    );
  }
}
