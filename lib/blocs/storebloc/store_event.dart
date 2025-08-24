import 'package:equatable/equatable.dart';
import '../../models/store_item.dart';

abstract class StoreEvent extends Equatable {
  const StoreEvent();

  @override
  List<Object?> get props => [];
}

class SelectFilter extends StoreEvent {
  final String filter;

  const SelectFilter(this.filter);

  @override
  List<Object?> get props => [filter];
}

class AddToCart extends StoreEvent {
  final StoreItem item;

  const AddToCart(this.item);

  @override
  List<Object?> get props => [item];
}

class RemoveFromCart extends StoreEvent {
  final StoreItem item;

  const RemoveFromCart(this.item);

  @override
  List<Object?> get props => [item];
}
