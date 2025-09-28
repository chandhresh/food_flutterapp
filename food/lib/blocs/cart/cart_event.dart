import 'package:equatable/equatable.dart';
import '../../models/food_item.dart';
import '../../models/restaurant.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class AddToCart extends CartEvent {
  final FoodItem foodItem;
  final int quantity;
  final String? specialInstructions;
  final Restaurant? restaurant;

  const AddToCart({
    required this.foodItem,
    required this.quantity,
    this.specialInstructions,
    this.restaurant,
  });

  @override
  List<Object> get props => [
    foodItem,
    quantity,
    specialInstructions ?? '',
    restaurant ?? '',
  ];
}

class RemoveFromCart extends CartEvent {
  final String foodItemId;

  const RemoveFromCart(this.foodItemId);

  @override
  List<Object> get props => [foodItemId];
}

class UpdateCartItemQuantity extends CartEvent {
  final String foodItemId;
  final int quantity;

  const UpdateCartItemQuantity({
    required this.foodItemId,
    required this.quantity,
  });

  @override
  List<Object> get props => [foodItemId, quantity];
}

class ClearCart extends CartEvent {
  const ClearCart();
}

class SetRestaurant extends CartEvent {
  final Restaurant restaurant;

  const SetRestaurant(this.restaurant);

  @override
  List<Object> get props => [restaurant];
}
