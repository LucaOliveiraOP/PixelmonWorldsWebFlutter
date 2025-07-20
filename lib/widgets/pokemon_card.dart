import 'package:flutter/material.dart';

class PokemonCard extends StatefulWidget {
  final Map<String, dynamic> pokemon;
  final bool isInMarket;
  final VoidCallback? onMarketAction;
  final bool showMarketActions;

  const PokemonCard({
    super.key,
    required this.pokemon,
    this.isInMarket = false,
    this.onMarketAction,
    this.showMarketActions = false,
  });

  @override
  State<PokemonCard> createState() => _PokemonCardState();
}

class _PokemonCardState extends State<PokemonCard> {
  bool _showBack = false;

  @override
  Widget build(BuildContext context) {
    final pokemon = widget.pokemon;
    final name = pokemon['name'] ?? '???';
    final level = pokemon['level'] ?? '?';
    final size = pokemon['size'] ?? 'Desconhecido';
    final ivs = pokemon['ivs'] ?? '???';
    final nature = pokemon['nature'] ?? '???';
    final moves =
        (pokemon['moves'] as List<dynamic>?)?.cast<String>().join(', ') ??
            'Sem golpes';
    final isShiny = (pokemon['shiny'] ?? false) == true;
    final imageUrl = isShiny
        ? (pokemon['imageShinyUrl'] ??
            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/shiny/0.png')
        : (pokemon['imageUrl'] ??
            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/0.png');

    final price = widget.pokemon['price'];

    return GestureDetector(
      onTap: () => setState(() => _showBack = !_showBack),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        transitionBuilder: (child, animation) =>
            FadeTransition(opacity: animation, child: child),
        child: _showBack
            ? backSide(name, level, size, ivs, nature, moves)
            : frontSide(imageUrl, name, level, size, nature, isShiny, price),
      ),
    );
  }

  Widget frontSide(String imageUrl, String name, Object level, String size,
      String nature, bool shiny, Object? price) {
    return Stack(
      key: const ValueKey('front'),
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: const LinearGradient(
                colors: [Colors.black, Colors.red],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 6,
                  offset: const Offset(0, 3)),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  width: 128,
                  height: 128,
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) => const Icon(
                        Icons.catching_pokemon,
                        size: 48,
                        color: Colors.white),
                  ),
                ),
              ),
              Row(
                children: [
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          'Lv $level',
                          style: const TextStyle(
                              color: Colors.white70, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.white),
                    onPressed: () {
                      // TODO: Editar Pokémon
                    },
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text('Tamanho: $size',
                  style: const TextStyle(color: Colors.white70, fontSize: 12)),
              Text('Nature: $nature',
                  style: const TextStyle(color: Colors.white70, fontSize: 12)),
              if (widget.isInMarket && price != null) ...[
                const SizedBox(height: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  decoration: BoxDecoration(
                    color: Colors.green.shade700,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '\$${price.toString()}',
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
              // if (widget.showMarketActions)
              //   Padding(
              //     padding: const EdgeInsets.only(top: 12),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.end,
              //       children: [
              //         ElevatedButton(
              //           onPressed: widget.onMarketAction ??
              //               () {
              //                 // TODO: ação do botão no mercado, ex: comprar/vender
              //               },
              //           child: Text(widget.isInMarket ? 'Remover' : 'Comprar'),
              //         ),
              //       ],
              //     ),
              //   ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: () => setState(() => _showBack = true),
                  child: const Text('Clique para mais detalhes'),
                ),
              )
            ],
          ),
        ),
        if (shiny)
          Positioned(
            top: 8,
            right: 8,
            child: Icon(Icons.star,
                color: Colors.yellowAccent.shade400,
                size: 36,
                shadows: [
                  Shadow(color: Colors.yellow.shade700, blurRadius: 8),
                ]),
          ),
      ],
    );
  }

  Widget backSide(String name, Object level, String size, String ivs,
      String nature, String moves) {
    return Container(
      key: const ValueKey('back'),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(
            colors: [Colors.black, Colors.red],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 6,
              offset: const Offset(0, 3)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Detalhes Avançados',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14)),
          const SizedBox(height: 8),
          Text('Nome: $name',
              style: const TextStyle(color: Colors.white70, fontSize: 12)),
          Text('Nível: $level',
              style: const TextStyle(color: Colors.white70, fontSize: 12)),
          Text('Tamanho: $size',
              style: const TextStyle(color: Colors.white70, fontSize: 12)),
          Text('IVs: $ivs',
              style: const TextStyle(color: Colors.white70, fontSize: 12)),
          Text('Nature: $nature',
              style: const TextStyle(color: Colors.white70, fontSize: 12)),
          const SizedBox(height: 8),
          const Text('Golpes:',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12)),
          Expanded(
            child: SingleChildScrollView(
              child: Text(
                moves,
                style: const TextStyle(color: Colors.white70, fontSize: 11),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.bottomRight,
            child: TextButton(
              onPressed: () => setState(() => _showBack = false),
              child:
                  const Text('Voltar', style: TextStyle(color: Colors.white70)),
            ),
          )
        ],
      ),
    );
  }
}
