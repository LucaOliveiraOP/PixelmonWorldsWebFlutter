import 'package:flutter/material.dart';
import 'package:pixelmonworldsweb/pages/dyn_map.dart';
import 'package:pixelmonworldsweb/widgets/buttons/login_register_buttons.dart';
import 'package:pixelmonworldsweb/widgets/nav_item.dart';

class LandingPageNavBar extends StatelessWidget {
  const LandingPageNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        NavItem(label: 'Início', icon: Icons.home),
        SizedBox(width: 12),
        NavItem(label: 'Sobre', icon: Icons.info),
        SizedBox(width: 12),
        NavItem(label: 'Vote', icon: Icons.how_to_vote),
        SizedBox(width: 12),
        NavItem(label: 'Loja', icon: Icons.store),
        SizedBox(width: 12),
        NavItem(label: 'FAQ', icon: Icons.help_outline),
        SizedBox(width: 12),
        NavItem(label: 'Discord', icon: Icons.discord),
        SizedBox(width: 12),
        NavItem(
          label: 'Mapa Online',
          icon: Icons.travel_explore,
          ontap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => DynmapPage()),
            );
          },
        ),
        Spacer(),
        LoginRegisterButtons(),
      ],
    );
  }
}
