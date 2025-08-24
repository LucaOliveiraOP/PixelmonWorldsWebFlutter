import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixelmonworldsweb/blocs/storebloc/store_bloc.dart';
import 'package:pixelmonworldsweb/blocs/storebloc/store_event.dart';
import 'package:pixelmonworldsweb/blocs/storebloc/store_state.dart';
import 'package:pixelmonworldsweb/models/store_item.dart';
import 'package:pixelmonworldsweb/widgets/store_drawer.dart';
import 'package:pixelmonworldsweb/widgets/buttons/cart_button.dart';

class StorePage extends StatelessWidget {
  const StorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),
      body: Row(
        children: [
          SizedBox(
            width: 260,
            child: BlocBuilder<StoreBloc, StoreState>(
              builder: (context, state) {
                return StoreDrawer(
                  selectedType: state.selectedFilter,
                  onFilterSelected: (type) {
                    context.read<StoreBloc>().add(SelectFilter(type));
                  },
                );
              },
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: BlocBuilder<StoreBloc, StoreState>(
                builder: (context, state) {
                  final filteredItems = state.filteredItems;
                  return GridView.builder(
                    itemCount: filteredItems.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1.10,
                    ),
                    itemBuilder: (context, index) {
                      final item = filteredItems[index];
                      return _StoreItemCard(
                        item: item,
                        onAddToCart: (item) {
                          context.read<StoreBloc>().add(AddToCart(item));
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Text('${item.name} adicionado ao carrinho!'),
                            ),
                          );
                        },
                        onBuy: (item) {
                          context.read<StoreBloc>().add(AddToCart(item));
                          showCartDrawer(context);
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------
// WIDGETS AUXILIARES (mantidos iguais ao seu código original)
// ---------------------------------------------

class _StoreItemCard extends StatelessWidget {
  final StoreItem item;
  final void Function(StoreItem) onAddToCart;
  final void Function(StoreItem) onBuy;

  const _StoreItemCard({
    required this.item,
    required this.onAddToCart,
    required this.onBuy,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF1C1C1C),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(child: Image.asset(item.image, fit: BoxFit.contain)),
            Text(
              item.name,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              'R\$ ${item.price.toStringAsFixed(2)}',
              style: const TextStyle(
                color: Colors.greenAccent,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.green.shade600,
                        Colors.greenAccent.shade700
                      ],
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      foregroundColor: Colors.black,
                      shadowColor: Colors.transparent,
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () => onBuy(item),
                    label: const Text(
                      'Comprar',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.greenAccent.shade700,
                        Colors.lightGreenAccent
                      ],
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.add_shopping_cart, size: 16),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      foregroundColor: Colors.black,
                      shadowColor: Colors.transparent,
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () => onAddToCart(item),
                    label: const Text(
                      'Adicionar',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
