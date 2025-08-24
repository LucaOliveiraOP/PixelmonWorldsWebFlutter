import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pixelmonworldsweb/widgets/buttons/animated_button.dart';
import 'package:pixelmonworldsweb/widgets/server_status_widget.dart';
import 'package:pixelmonworldsweb/widgets/section_container.dart';

class LandingPage extends StatelessWidget {
  final dynamic authState;

  const LandingPage({super.key, required this.authState});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return SizedBox(
      height: screenHeight,
      width: screenWidth,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/pixelmonfoto.png',
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black.withOpacity(0.6),
          ),
          SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: screenHeight,
              ),
              child: Column(
                children: [
                  const _HeroTexts(),
                  const SizedBox(height: 32),
                  const ServerStatusWidget(),
                  const SizedBox(height: 32),
                  _HeroButtons(isMobile: isMobile),
                  const SizedBox(height: 24),
                  _SectionsList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroTexts extends StatelessWidget {
  const _HeroTexts();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const SizedBox(height: 64),
          Image.asset(
            'assets/minecraft_title2.png',
            height: isMobile ? 100 : 180,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 32),
          const SizedBox(height: 32),
          Text(
            'Servidor brasileiro de Pixelmon desde 2014!\nO Antigo PokéVicio está de volta, agora de cara nova!',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: isMobile ? 10 : 12,
                  letterSpacing: -0.5,
                  height: 1.2,
                  color: Colors.white,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _HeroButtons extends StatelessWidget {
  final bool isMobile;
  const _HeroButtons({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return isMobile
        ? Column(
            children: const [
              AnimatedButton(
                label: 'play.pixelmon-worlds.com',
                onPressed: null,
                filled: true,
              ),
              SizedBox(height: 12),
              AnimatedButton(
                label: 'Baixar Launcher',
                onPressed: null,
                filled: false,
              ),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              AnimatedButton(
                label: 'play.pixelmon-worlds.com',
                onPressed: null,
                filled: true,
              ),
              SizedBox(width: 16),
              AnimatedButton(
                label: 'Baixar Launcher',
                onPressed: null,
                filled: false,
              ),
            ],
          );
  }
}

class _SectionsList extends StatelessWidget {
  const _SectionsList();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    final sections = [
      SectionContainer(
        title: 'Loja Oficial',
        content:
            'Adquira itens exclusivos, ranks VIP e muito mais em nossa loja online.',
        icon: Icons.storefront,
        onTap: () => context.go('/loja'),
      ),
      SectionContainer(
        title: 'Mapa dos Mundos',
        content: 'Saiba exatamente onde está e onde explorar!',
        icon: Icons.travel_explore,
        onTap: () => context.go('/mapa'),
      ),
      const SectionContainer(
        title: 'Vote no Servidor',
        content: 'Apoie nosso servidor votando e ganhe recompensas especiais!',
        icon: Icons.how_to_vote,
      ),
      const SectionContainer(
        title: 'Nossas Redes Sociais',
        content:
            'Junte-se às nossas comunidades e fique por dentro das novidades!',
        icon: Icons.chat_bubble_outline,
      ),
      const SectionContainer(
        title: 'Servidor Dedicado',
        content:
            'Infraestrutura robusta com capacidade para 500 jogadores simultâneos!',
        icon: Icons.dns,
      ),
    ];

    if (isMobile) {
      return SizedBox(
        height: 220,
        child: PageView.builder(
          controller: PageController(viewportFraction: 0.8),
          itemCount: sections.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: sections[index],
            );
          },
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Center(
          child: Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: WrapAlignment.center,
            children: sections,
          ),
        ),
      );
    }
  }
}
