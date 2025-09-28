import 'package:equatable/equatable.dart';
import '../../models/order.dart';
import '../../models/cart_item.dart';
import '../../models/restaurant.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class PlaceOrder extends OrderEvent {
  final Restaurant restaurant;
  final List<CartItem> items;
  final String deliveryAddress;
  final String? contactNumber;

  const PlaceOrder({
    required this.restaurant,
    required this.items,
    required this.deliveryAddress,
    this.contactNumber,
  });

  @override
  List<Object> get props => [restaurant, items, deliveryAddress, contactNumber ?? ''];
}

class LoadOrderDetails extends OrderEvent {
  final String orderId;

  const LoadOrderDetails(this.orderId);

  @override
  List<Object> get props => [orderId];
}

class UpdateOrderStatus extends OrderEvent {
  final String orderId;
  final OrderStatus status;

  const UpdateOrderStatus({
    required this.orderId,
    required this.status,
  });

  @override
  List<Object> get props => [orderId, status];
}
