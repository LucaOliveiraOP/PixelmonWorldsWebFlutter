import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/store_item.dart';
import 'store_event.dart';
import 'store_state.dart';

class StoreBloc extends Bloc<StoreEvent, StoreState> {
  StoreBloc()
      : super(StoreState(
            selectedFilter: '', allItems: StoreItem.allItems, cart: [])) {
    on<SelectFilter>((event, emit) {
      emit(state.copyWith(selectedFilter: event.filter));
    });

    on<AddToCart>((event, emit) {
      final existingCart = List<CartItem>.from(state.cart);
      final index =
          existingCart.indexWhere((cartItem) => cartItem.item == event.item);

      if (index >= 0) {
        final updatedItem = existingCart[index]
            .copyWith(quantity: existingCart[index].quantity + 1);
        existingCart[index] = updatedItem;
      } else {
        existingCart.add(CartItem(item: event.item, quantity: 1));
      }

      emit(state.copyWith(cart: existingCart));
    });

    on<RemoveFromCart>((event, emit) {
      final existingCart = List<CartItem>.from(state.cart);
      final index =
          existingCart.indexWhere((cartItem) => cartItem.item == event.item);

      if (index >= 0) {
        final currentQuantity = existingCart[index].quantity;
        if (currentQuantity > 1) {
          final updatedItem =
              existingCart[index].copyWith(quantity: currentQuantity - 1);
          existingCart[index] = updatedItem;
        } else {
          existingCart.removeAt(index);
        }
        emit(state.copyWith(cart: existingCart));
      }
    });
  }
}
