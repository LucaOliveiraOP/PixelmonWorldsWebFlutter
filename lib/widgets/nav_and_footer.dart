import 'package:flutter/material.dart';
import 'package:pixelmonworldsweb/widgets/landing_page_nav_bar.dart';
import 'package:pixelmonworldsweb/widgets/landing_page_footer.dart';

class NavAndFooter extends StatelessWidget {
  final Widget child;

  const NavAndFooter({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                const Icon(Icons.catching_pokemon, color: Colors.red, size: 36),
                const SizedBox(width: 16),
                Expanded(child: LandingPageNavBar()),
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
