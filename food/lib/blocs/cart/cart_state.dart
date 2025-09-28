import 'package:equatable/equatable.dart';
import '../../models/cart_item.dart';
import '../../models/restaurant.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {
  const CartInitial();
}

class CartLoaded extends CartState {
  final List<CartItem> items;
  final Restaurant? restaurant;

  const CartLoaded({
    required this.items,
    this.restaurant,
  });

  double get subtotal => items.fold(0, (sum, item) => sum + item.totalPrice);

  double get deliveryFee => restaurant?.deliveryFee ?? 0.0;

  double get tax => subtotal * 0.08;

  double get total => subtotal + deliveryFee + tax;

  int get itemCount => items.fold(0, (sum, item) => sum + item.quantity);

  CartLoaded copyWith({
    List<CartItem>? items,
    Restaurant? restaurant,
  }) {
    return CartLoaded(
      items: items ?? this.items,
      restaurant: restaurant ?? this.restaurant,
    );
  }

  @override
  List<Object> get props => [items, restaurant ?? ''];
}
