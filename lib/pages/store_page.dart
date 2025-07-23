import 'package:flutter/material.dart';

class StorePage extends StatelessWidget {
  const StorePage({super.key});

  final List<StoreItem> items = const [
    StoreItem(
      name: 'Rank VIP',
      description: 'Tenha benefícios exclusivos e destaque no servidor.',
      price: 29.99,
      icon: Icons.star,
    ),
    StoreItem(
      name: 'Pacote de Pokébolas',
      description: '50 Pokébolas para ajudar na sua captura.',
      price: 9.99,
      icon: Icons.sports_baseball,
    ),
    StoreItem(
      name: 'MTs Especiais',
      description: 'Movimentos técnicos raros para seus Pokémon.',
      price: 14.99,
      icon: Icons.flash_on,
    ),
    StoreItem(
      name: 'Skins Exclusivas',
      description: 'Customize sua experiência com skins únicas.',
      price: 19.99,
      icon: Icons.palette,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Loja Oficial'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: ListView.separated(
          itemCount: items.length,
          separatorBuilder: (_, __) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            final item = items[index];
            return _StoreItemCard(item: item);
          },
        ),
      ),
    );
  }
}

class StoreItem {
  final String name;
  final String description;
  final double price;
  final IconData icon;

  const StoreItem({
    required this.name,
    required this.description,
    required this.price,
    required this.icon,
  });
}

class _StoreItemCard extends StatelessWidget {
  final StoreItem item;

  const _StoreItemCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[900],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        child: Row(
          children: [
            Icon(item.icon, size: 48, color: Colors.deepPurpleAccent),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    item.description,
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Column(
              children: [
                Text(
                  'R\$ ${item.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: Colors.greenAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurpleAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    // Aqui você pode colocar a lógica de compra
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text('Compra do ${item.name} realizada!')),
                    );
                  },
                  child: const Text('Comprar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
