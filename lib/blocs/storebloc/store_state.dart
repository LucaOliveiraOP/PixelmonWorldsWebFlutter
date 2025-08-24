import 'package:equatable/equatable.dart';
import '../../models/store_item.dart';

class CartItem extends Equatable {
  final StoreItem item;
  final int quantity;

  const CartItem({required this.item, this.quantity = 1});

  CartItem copyWith({int? quantity}) {
    return CartItem(
      item: item,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  List<Object?> get props => [item, quantity];
}

class StoreState extends Equatable {
  final String selectedFilter;
  final List<StoreItem> allItems;
  final List<CartItem> cart;

  const StoreState({
    required this.selectedFilter,
    required this.allItems,
    required this.cart,
  });

  // Itens filtrados conforme o filtro ativo
  List<StoreItem> get filteredItems {
    if (selectedFilter.isEmpty) return allItems;
    return allItems
        .where((item) => item.itemTypes.contains(selectedFilter))
        .toList();
  }

  // Total do carrinho (soma do preço * quantidade)
  double get cartTotal =>
      cart.fold(0.0, (total, e) => total + e.item.price * e.quantity);

  StoreState copyWith({
    String? selectedFilter,
    List<StoreItem>? allItems,
    List<CartItem>? cart,
  }) {
    return StoreState(
      selectedFilter: selectedFilter ?? this.selectedFilter,
      allItems: allItems ?? this.allItems,
      cart: cart ?? this.cart,
    );
  }

  @override
  List<Object?> get props => [selectedFilter, allItems, cart];
}
