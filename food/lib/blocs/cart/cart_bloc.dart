import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/cart_item.dart';
import '../../models/restaurant.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartInitial()) {
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
    on<UpdateCartItemQuantity>(_onUpdateCartItemQuantity);
    on<ClearCart>(_onClearCart);
    on<SetRestaurant>(_onSetRestaurant);
  }

  void _onAddToCart(AddToCart event, Emitter<CartState> emit) {
    final currentState = state;

    if (currentState is CartLoaded) {
      final existingItemIndex = currentState.items.indexWhere(
        (item) => item.foodItem.id == event.foodItem.id,
      );

      List<CartItem> updatedItems;
      Restaurant? restaurant = currentState.restaurant ?? event.restaurant;

      if (existingItemIndex != -1) {
        
        updatedItems = List.from(currentState.items);
        updatedItems[existingItemIndex] = updatedItems[existingItemIndex]
            .copyWith(
              quantity:
                  updatedItems[existingItemIndex].quantity + event.quantity,
              specialInstructions: event.specialInstructions,
            );
      } else {
        
        updatedItems = List.from(currentState.items)
          ..add(
            CartItem(
              foodItem: event.foodItem,
              quantity: event.quantity,
              specialInstructions: event.specialInstructions,
            ),
          );
      }

      emit(CartLoaded(items: updatedItems, restaurant: restaurant));
    } else {
      
      emit(
        CartLoaded(
          items: [
            CartItem(
              foodItem: event.foodItem,
              quantity: event.quantity,
              specialInstructions: event.specialInstructions,
            ),
          ],
          restaurant: event.restaurant,
        ),
      );
    }
  }

  void _onRemoveFromCart(RemoveFromCart event, Emitter<CartState> emit) {
    final currentState = state;

    if (currentState is CartLoaded) {
      final updatedItems = currentState.items
          .where((item) => item.foodItem.id != event.foodItemId)
          .toList();

      if (updatedItems.isEmpty) {
        emit(const CartInitial());
      } else {
        emit(currentState.copyWith(items: updatedItems));
      }
    }
  }

  void _onUpdateCartItemQuantity(
    UpdateCartItemQuantity event,
    Emitter<CartState> emit,
  ) {
    final currentState = state;

    if (currentState is CartLoaded) {
      if (event.quantity <= 0) {
        add(RemoveFromCart(event.foodItemId));
        return;
      }

      final updatedItems = currentState.items.map((item) {
        if (item.foodItem.id == event.foodItemId) {
          return item.copyWith(quantity: event.quantity);
        }
        return item;
      }).toList();

      emit(currentState.copyWith(items: updatedItems));
    }
  }

  void _onClearCart(ClearCart event, Emitter<CartState> emit) {
    emit(const CartInitial());
  }

  void _onSetRestaurant(SetRestaurant event, Emitter<CartState> emit) {
    final currentState = state;
    if (currentState is CartLoaded) {
      emit(currentState.copyWith(restaurant: event.restaurant));
    }
  }
}
