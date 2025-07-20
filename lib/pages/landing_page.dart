import 'package:flutter/material.dart';
import 'package:pixelmonworldsweb/blocs/authbloc/auth_state.dart';
import 'package:pixelmonworldsweb/pages/dashboard_page.dart';
import 'package:pixelmonworldsweb/widgets/buttons/animated_button.dart';
import 'package:pixelmonworldsweb/widgets/server_status_widget.dart';
import 'package:pixelmonworldsweb/widgets/section_container.dart';

class LandingPage extends StatelessWidget {
  final dynamic authState;

  const LandingPage({super.key, required this.authState});

  @override
  Widget build(BuildContext context) {
    if (authState is AuthSuccess) {
      // Mostra dashboard se logado
      return DashboardContent(playerData: authState.playerData);
    }

    // Caso não logado, mostra conteúdo normal da landing page
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: const [
        _HeroTexts(),
        SizedBox(height: 32),
        ServerStatusWidget(online: true, players: 153),
        SizedBox(height: 32),
        _HeroButtons(),
        SizedBox(height: 24),
        _SectionsList(),
      ],
    );
  }
}

class _HeroTexts extends StatelessWidget {
  const _HeroTexts();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Bem-vindo ao Pixelmon Worlds!',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontSize: 20,
                letterSpacing: -1,
                height: 1.2,
                color: Colors.white,
              ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 32),
        Text(
          'Servidor brasileiro de Pixelmon desde 2014!\n O Antigo PokéVicio está de volta, agora de cara nova!',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: 10,
                letterSpacing: -0.5,
                height: 1.2,
                color: Colors.white70,
              ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _HeroButtons extends StatelessWidget {
  const _HeroButtons();

  @override
  Widget build(BuildContext context) {
    return Row(
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
    final sections = const [
      SectionContainer(
        title: 'Servidor Dedicado',
        content:
            'Infraestrutura robusta com capacidade para 500 jogadores simultâneos!',
        icon: Icons.dns,
      ),
      SectionContainer(
        title: 'Sobre Nós',
        content: 'Somos uma comunidade apaixonada por Pixelmon desde 2014.',
        icon: Icons.info_outline,
      ),
      SectionContainer(
        title: 'Vote no Servidor',
        content: 'Apoie nosso servidor votando e ganhe recompensas especiais!',
        icon: Icons.how_to_vote,
      ),
      SectionContainer(
        title: 'Loja Oficial',
        content:
            'Adquira itens exclusivos, ranks VIP e muito mais em nossa loja online.',
        icon: Icons.storefront,
      ),
      SectionContainer(
        title: 'Nosso Discord',
        content:
            'Junte-se à nossa comunidade e fique por dentro das novidades!',
        icon: Icons.chat_bubble_outline,
      ),
    ];

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
