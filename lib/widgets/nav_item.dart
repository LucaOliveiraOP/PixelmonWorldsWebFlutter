import 'package:flutter/material.dart';

class NavItem extends StatefulWidget {
  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback? ontap;
  final bool isDrawer;

  const NavItem({
    super.key,
    required this.label,
    required this.icon,
    required this.selected,
    this.ontap,
    this.isDrawer = false,
  });

  @override
  State<NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<NavItem> {
  bool _hovering = false;

  // Gradiente para itens selecionados
  final LinearGradient _selectedGradient = const LinearGradient(
    colors: [Color(0xFFFBC570), Color(0xFFBA0F0A)],
  );

  @override
  Widget build(BuildContext context) {
    final baseColor = Colors.white;
    final hoverColor = Colors.red[700]!;

    final isSelected = widget.selected;
    final color =
        isSelected ? Colors.white : (_hovering ? hoverColor : baseColor);

    Widget gradientText(String text) {
      if (!isSelected) {
        return Text(
          text,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.normal,
          ),
        );
      }

      return ShaderMask(
        shaderCallback: (bounds) => _selectedGradient.createShader(
          Rect.fromLTWH(0, 0, bounds.width, bounds.height),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white, // Necessário para exibir o shader
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    Widget gradientIcon(IconData icon) {
      if (!isSelected) {
        return Icon(
          icon,
          color: color,
          size: 18,
        );
      }

      return ShaderMask(
        shaderCallback: (bounds) => _selectedGradient.createShader(
          Rect.fromLTWH(0, 0, bounds.width, bounds.height),
        ),
        child: Icon(
          icon,
          size: 18,
          color: Colors.white, // Necessário para exibir o shader
        ),
      );
    }

    // ✅ Drawer layout
    if (widget.isDrawer) {
      return ListTile(
        leading: gradientIcon(widget.icon),
        title: gradientText(widget.label),
        selected: widget.selected,
        selectedTileColor: Colors.white12,
        onTap: widget.ontap,
      );
    }

    // ✅ Top/Horizontal navigation bar layout
    return GestureDetector(
      onTap: widget.ontap,
      child: MouseRegion(
        onEnter: (_) => setState(() => _hovering = true),
        onExit: (_) => setState(() => _hovering = false),
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 200),
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 12,
                letterSpacing: 0,
                color: color,
                fontWeight:
                    widget.selected ? FontWeight.bold : FontWeight.normal,
              ),
          child: Row(
            children: [
              gradientIcon(widget.icon),
              const SizedBox(width: 6),
              gradientText(widget.label),
              const SizedBox(width: 6),
            ],
          ),
        ),
      ),
    );
  }
}
