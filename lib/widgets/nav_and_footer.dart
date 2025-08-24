import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pixelmonworldsweb/widgets/lading_page_drawer.dart';
import 'package:pixelmonworldsweb/widgets/landing_page_nav_bar.dart';
import 'package:pixelmonworldsweb/widgets/landing_page_footer.dart';

class NavAndFooter extends StatelessWidget {
  final Widget child;

  const NavAndFooter({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    final bool isHomePage = GoRouter.of(context).location == '/';

    return Scaffold(
      drawer: isMobile ? const LandingPageDrawer() : null,
      appBar: isMobile
          ? AppBar(
              title: const Text('Pixelmon Worlds'),
              backgroundColor: Colors.black87,
              elevation: 0,
            )
          : null,
      body: Column(
        children: [
          if (!isMobile)
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  isHomePage
                      ? const Icon(Icons.catching_pokemon,
                          color: Colors.red, size: 36)
                      : Image.asset(
                          'assets/minecraft_title2.png',
                          height: isMobile ? 20 : 45,
                          fit: BoxFit.contain,
                        ),
                  const SizedBox(width: 16),
                  const Expanded(child: LandingPageNavBar()),
                ],
              ),
            ),
          Expanded(child: child),
          const LandingPageFooter(),
        ],
      ),
    );
  }
}
