import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pixelmonworldsweb/widgets/buttons/login_register_buttons.dart';
import 'nav_item.dart';

class LandingPageNavBar extends StatelessWidget {
  const LandingPageNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final currentRoute = GoRouter.of(context).location;

    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        NavItem(
          label: 'Início',
          icon: Icons.home,
          selected: currentRoute == '/',
          ontap: () => context.go('/'),
        ),
        const SizedBox(width: 12),
        NavItem(
          label: 'Dashboard',
          icon: Icons.dashboard,
          selected: currentRoute == '/',
          ontap: () => context.go('/'),
        ),
        const SizedBox(width: 12),
        NavItem(
          label: 'Loja',
          icon: Icons.store,
          selected: currentRoute == '/loja',
          ontap: () => context.go('/loja'),
        ),
        const SizedBox(width: 12),
        NavItem(
          label: 'Mapa',
          icon: Icons.travel_explore,
          selected: currentRoute == '/mapa',
          ontap: () => context.go('/mapa'),
        ),
        const SizedBox(width: 12),
        NavItem(
          label: 'Redes Sociais',
          icon: Icons.chat_bubble_outline,
          selected: currentRoute == '/discord',
          ontap: () => context.go('/discord'),
        ),
        const SizedBox(width: 12),
        NavItem(
          label: 'Tutoriais',
          icon: Icons.help_outline,
          selected: currentRoute == '/faq',
          ontap: () => context.go('/faq'),
        ),
        const SizedBox(width: 12),
        NavItem(
          label: 'Vote',
          icon: Icons.how_to_vote,
          selected: currentRoute == '/vote',
          ontap: () => context.go('/vote'),
        ),
        const SizedBox(width: 12),
        const Spacer(),
        LoginRegisterButtons(),
      ],
    );
  }
}
