import 'package:flutter/material.dart';
import 'package:pixelmonworldsweb/widgets/pokemon_card.dart';
import 'package:pixelmonworldsweb/data/market_data.dart' as market;

class DashboardContent extends StatefulWidget {
  final Map<String, dynamic> playerData;

  const DashboardContent({super.key, required this.playerData});

  @override
  State<DashboardContent> createState() => _DashboardContentState();
}

class _DashboardContentState extends State<DashboardContent> {
  late List<Map<String, dynamic>> party;

  @override
  void initState() {
    super.initState();
    party = (widget.playerData['party'] != null &&
            (widget.playerData['party'] as List).isNotEmpty)
        ? List<Map<String, dynamic>>.from(widget.playerData['party'])
        : [
            {
              'name': 'Bulbasaur',
              'level': 12,
              'size': 'Médio',
              'ivs': '31/31/31/31/31/31',
              'nature': 'Modesto',
              'moves': ['Tackle', 'Vine Whip', 'Growl', 'Leech Seed'],
              'imageUrl':
                  'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png',
            },
            {
              'name': 'Charmander',
              'level': 15,
              'size': 'Pequeno',
              'ivs': '28/30/29/31/30/27',
              'nature': 'Brave',
              'moves': ['Scratch', 'Ember', 'Smokescreen', 'Dragon Rage'],
              'imageUrl':
                  'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/4.png',
            },
          ];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Olá!',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 12),
            Text('Essa é a sua equipe atual :D',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: Colors.white70)),
            Text('Aqui, você pode editar ou vender algum integrante da equipe.',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: Colors.white70)),
            const SizedBox(height: 24),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: party.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 6,
                childAspectRatio: 0.8,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
              ),
              itemBuilder: (_, i) {
                final pokemon = party[i];
                return Draggable<Map<String, dynamic>>(
                  data: pokemon,
                  feedback: Material(
                    color: Colors.transparent,
                    child: PokemonCard(
                      pokemon: pokemon,
                      showMarketActions: false,
                    ),
                  ),
                  childWhenDragging: Opacity(
                    opacity: 0.3,
                    child: PokemonCard(
                      pokemon: pokemon,
                      showMarketActions: false,
                    ),
                  ),
                  child: PokemonCard(
                    pokemon: pokemon,
                    showMarketActions: false,
                  ),
                );
              },
            ),
            const SizedBox(height: 32),
            Text('Pokémons no Mercado (${market.marketPokemons.length})',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 12),
            DragTarget<Map<String, dynamic>>(
              onAccept: (pokemon) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  setState(() {
                    party.remove(pokemon);
                    market.marketPokemons.add(pokemon);
                  });
                });
              },
              builder: (context, candidateData, rejectedData) {
                return Container(
                  decoration: BoxDecoration(
                    border: candidateData.isNotEmpty
                        ? Border.all(color: Colors.green, width: 4)
                        : Border.all(color: Colors.white24, width: 2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  height: 400,
                  child: market.marketPokemons.isEmpty
                      ? const Center(
                          child: Text(
                            'Nenhum Pokémon listado no momento.',
                            style: TextStyle(color: Colors.white54),
                          ),
                        )
                      : GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: market.marketPokemons.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 6,
                            childAspectRatio: 0.8,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12,
                          ),
                          itemBuilder: (_, i) {
                            final poke = market.marketPokemons[i];
                            return PokemonCard(
                              pokemon: poke,
                              showMarketActions: true,
                              isInMarket: true,
                            );
                          },
                        ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
