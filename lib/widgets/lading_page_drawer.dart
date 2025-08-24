import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pixelmonworldsweb/widgets/buttons/login_register_buttons.dart';
import 'nav_item.dart';

class LandingPageDrawer extends StatelessWidget {
  const LandingPageDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final currentRoute = GoRouter.of(context).location;

    return Drawer(
      backgroundColor: Colors.grey[900],
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
        children: [
          Text(
            'Pixelmon Worlds',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 32),
          NavItem(
            label: 'Início',
            icon: Icons.home,
            selected: currentRoute == '/',
            ontap: () {
              context.push('/');
              Navigator.pop(context);
            },
            isDrawer: true,
          ),
          NavItem(
            label: 'Dashboard',
            icon: Icons.dashboard,
            selected: currentRoute == '/dashboard',
            ontap: () {
              context.push('/dashboard');
              Navigator.pop(context);
            },
            isDrawer: true,
          ),
          NavItem(
            label: 'Loja',
            icon: Icons.store,
            selected: currentRoute == '/loja',
            ontap: () {
              context.push('/loja');
              Navigator.pop(context);
            },
            isDrawer: true,
          ),
          NavItem(
            label: 'Mapa',
            icon: Icons.travel_explore,
            selected: currentRoute == '/mapa',
            ontap: () {
              context.push('/mapa');
              Navigator.pop(context);
            },
            isDrawer: true,
          ),
          NavItem(
            label: 'Redes Sociais',
            icon: Icons.chat_bubble_outline,
            selected: currentRoute == '/discord',
            ontap: () {
              context.push('/discord');
              Navigator.pop(context);
            },
            isDrawer: true,
          ),
          NavItem(
            label: 'Tutoriais',
            icon: Icons.help_outline,
            selected: currentRoute == '/faq',
            ontap: () {
              context.push('/faq');
              Navigator.pop(context);
            },
            isDrawer: true,
          ),
          NavItem(
            label: 'Vote',
            icon: Icons.how_to_vote,
            selected: currentRoute == '/vote',
            ontap: () {
              context.push('/vote');
              Navigator.pop(context);
            },
            isDrawer: true,
          ),
          const SizedBox(height: 32),
          const Divider(color: Colors.white24),
          const SizedBox(height: 16),
          const LoginRegisterButtons(),
        ],
      ),
    );
  }
}
