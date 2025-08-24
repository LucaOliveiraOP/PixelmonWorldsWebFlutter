import 'package:flutter/material.dart';
import 'package:pixelmonworldsweb/widgets/player_head.dart';

class StoreDrawer extends StatelessWidget {
  final void Function(String) onFilterSelected;
  final String selectedType;
  const StoreDrawer({
    super.key,
    required this.onFilterSelected,
    required this.selectedType,
  });
  static const Map<String, Color> typeColors = {
    'destaque': Color(0xFFFFD700),
    'vip': Color(0xFF9C27B0),
    'chaves': Color(0xFFFF5722),
    'lendarios': Color(0xFF00BCD4),
    'passes': Color(0xFF009688),
    'pokegacha': Color(0xFFE91E63),
    'tokens': Color(0xFF3F51B5),
    'modificadores': Color(0xFF607D8B),
    'armas': Color(0xFFF44336),
  };
  Color getColor(String type) {
    return typeColors[type] ?? Colors.greenAccent;
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      thumbVisibility: true,
      thickness: 6,
      radius: const Radius.circular(4),
      interactive: true,
      trackVisibility: true,
      scrollbarOrientation: ScrollbarOrientation.right,
      child: Container(
        color: Colors.black,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const Center(child: DrawerSectionTitle(title: 'ITENS')),
            ...[
              {'icon': Icons.star, 'title': 'EM DESTAQUE', 'type': 'destaque'},
              {
                'icon': Icons.workspace_premium,
                'title': 'LOJA VIP',
                'type': 'vip'
              },
              {'icon': Icons.key, 'title': 'CHAVES', 'type': 'chaves'},
              {
                'icon': Icons.catching_pokemon,
                'title': 'LENDÁRIOS À ESCOLHA',
                'type': 'lendarios'
              },
              {
                'icon': Icons.card_membership,
                'title': 'PASSES PXBR',
                'type': 'passes'
              },
              {'icon': Icons.casino, 'title': 'POKÉGACHA', 'type': 'pokegacha'},
              {'icon': Icons.token, 'title': 'TOKENS', 'type': 'tokens'},
              {
                'icon': Icons.settings,
                'title': 'MODIFICADORES',
                'type': 'modificadores'
              },
              {
                'icon': Icons.security,
                'title': 'ARMAS E ARMADURAS',
                'type': 'armas'
              },
            ].map((item) {
              final type = item['type'] as String;
              final color = getColor(type);
              return DrawerOption(
                icon: item['icon'] as IconData,
                title: item['title'] as String,
                selected: selectedType == type,
                selectedColor: color,
                onTap: () => onFilterSelected(type),
              );
            }),
            const Divider(color: Colors.white24),
            const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 8),
                  PlayerHead(username: "Steve"),
                  SizedBox(height: 16),
                  Text(
                    'MAIOR CONTRIBUIDOR DO MÊS',
                    style: TextStyle(fontSize: 8, color: Colors.white70),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'eunaosoumaluco',
                    style: TextStyle(color: Colors.greenAccent, fontSize: 10),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerSectionTitle extends StatelessWidget {
  final String title;
  const DrawerSectionTitle({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Center(
        child: Text(
          title.toUpperCase(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.greenAccent,
          ),
        ),
      ),
    );
  }
}

class DrawerOption extends StatefulWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool selected;
  final Color selectedColor;
  const DrawerOption({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    required this.selected,
    required this.selectedColor,
  });
  @override
  State<DrawerOption> createState() => _DrawerOptionState();
}

class _DrawerOptionState extends State<DrawerOption> {
  bool isHover = false;
  @override
  Widget build(BuildContext context) {
    final color = widget.selected
        ? widget.selectedColor
        : (isHover ? widget.selectedColor.withOpacity(0.9) : Colors.white);
    return MouseRegion(
      onEnter: (_) => setState(() => isHover = true),
      onExit: (_) => setState(() => isHover = false),
      cursor: SystemMouseCursors.click,
      child: ListTile(
        leading: Icon(widget.icon, color: color),
        title: Text(
          widget.title,
          style: TextStyle(
            color: color,
            fontWeight: widget.selected ? FontWeight.bold : FontWeight.normal,
            fontSize: 12,
          ),
        ),
        selected: widget.selected,
        selectedTileColor: Colors.white10,
        onTap: widget.onTap,
      ),
    );
  }
}
