import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixelmonworldsweb/blocs/storebloc/store_bloc.dart';
import 'package:pixelmonworldsweb/blocs/storebloc/store_event.dart';
import 'package:pixelmonworldsweb/blocs/storebloc/store_state.dart';

class CartButton extends StatelessWidget {
  const CartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreBloc, StoreState>(
      builder: (context, state) {
        return Stack(
          children: [
            IconButton(
              icon: const Icon(Icons.shopping_cart, color: Colors.white),
              onPressed: () => showCartDrawer(context),
            ),
            if (state.cart.isNotEmpty)
              Positioned(
                right: 6,
                top: 6,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '${state.cart.length}',
                    style: const TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

void showCartDrawer(BuildContext context) {
  final storeBloc = context.read<StoreBloc>();

  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "Carrinho",
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (_, __, ___) => Align(
      alignment: Alignment.centerRight,
      child: FractionallySizedBox(
        widthFactor: 0.30,
        child: Material(
          color: const Color(0xFF1C1C1C),
          child: SafeArea(
            child: BlocProvider.value(
              value: storeBloc,
              child: BlocBuilder<StoreBloc, StoreState>(
                builder: (context, state) {
                  final cart = state.cart;

                  return Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          '🛒 Carrinho',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                      const Divider(color: Colors.white24),
                      Expanded(
                        child: cart.isEmpty
                            ? const Center(
                                child: Text(
                                  'Carrinho vazio',
                                  style: TextStyle(color: Colors.white70),
                                ),
                              )
                            : ListView.builder(
                                itemCount: cart.length,
                                itemBuilder: (context, index) {
                                  final cartItem = cart[index];
                                  return ListTile(
                                    leading: Image.asset(
                                      cartItem.item.image,
                                      fit: BoxFit.contain,
                                    ),
                                    title: Text(
                                      cartItem.item.name,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                    subtitle: Text(
                                      'R\$ ${cartItem.item.price.toStringAsFixed(2)} x ${cartItem.quantity} = R\$ ${(cartItem.item.price * cartItem.quantity).toStringAsFixed(2)}',
                                      style: const TextStyle(
                                          color: Colors.greenAccent),
                                    ),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.add_circle,
                                              color: Colors.greenAccent),
                                          onPressed: () {
                                            context
                                                .read<StoreBloc>()
                                                .add(AddToCart(cartItem.item));
                                          },
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.remove_circle,
                                              color: Colors.redAccent),
                                          onPressed: () {
                                            context.read<StoreBloc>().add(
                                                RemoveFromCart(cartItem.item));
                                            if (cart.length == 1 &&
                                                cartItem.quantity == 1) {
                                              Navigator.of(context).pop();
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Total:',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
                                Text(
                                  'R\$ ${state.cartTotal.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    color: Colors.greenAccent,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.greenAccent[700],
                                  foregroundColor: Colors.black,
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'Finalização ainda não disponível'),
                                    ),
                                  );
                                },
                                child: const Text('Finalizar Compra'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    ),
    transitionBuilder: (_, anim, __, child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1, 0),
          end: Offset.zero,
        ).animate(anim),
        child: child,
      );
    },
  );
}
