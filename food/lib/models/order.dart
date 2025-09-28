import 'package:equatable/equatable.dart';
import 'cart_item.dart';
import 'restaurant.dart';

enum OrderStatus {
  pending,
  confirmed,
  preparing,
  outForDelivery,
  delivered,
  cancelled,
}

class Order extends Equatable {
  final String id;
  final Restaurant restaurant;
  final List<CartItem> items;
  final double subtotal;
  final double deliveryFee;
  final double tax;
  final double total;
  final OrderStatus status;
  final DateTime createdAt;
  final DateTime? estimatedDeliveryTime;
  final String deliveryAddress;
  final String? contactNumber;

  const Order({
    required this.id,
    required this.restaurant,
    required this.items,
    required this.subtotal,
    required this.deliveryFee,
    required this.tax,
    required this.total,
    required this.status,
    required this.createdAt,
    this.estimatedDeliveryTime,
    required this.deliveryAddress,
    this.contactNumber,
  });

  factory Order.fromCart({
    required String id,
    required Restaurant restaurant,
    required List<CartItem> items,
    required String deliveryAddress,
    String? contactNumber,
  }) {
    final subtotal = items.fold<double>(0, (sum, item) => sum + item.totalPrice);
    final deliveryFee = restaurant.deliveryFee;
    final tax = subtotal * 0.08; // 8% tax
    final total = subtotal + deliveryFee + tax;
    final estimatedDeliveryTime = DateTime.now().add(
      Duration(minutes: restaurant.deliveryTime + 10),
    );

    return Order(
      id: id,
      restaurant: restaurant,
      items: items,
      subtotal: subtotal,
      deliveryFee: deliveryFee,
      tax: tax,
      total: total,
      status: OrderStatus.pending,
      createdAt: DateTime.now(),
      estimatedDeliveryTime: estimatedDeliveryTime,
      deliveryAddress: deliveryAddress,
      contactNumber: contactNumber,
    );
  }

  Order copyWith({
    String? id,
    Restaurant? restaurant,
    List<CartItem>? items,
    double? subtotal,
    double? deliveryFee,
    double? tax,
    double? total,
    OrderStatus? status,
    DateTime? createdAt,
    DateTime? estimatedDeliveryTime,
    String? deliveryAddress,
    String? contactNumber,
  }) {
    return Order(
      id: id ?? this.id,
      restaurant: restaurant ?? this.restaurant,
      items: items ?? this.items,
      subtotal: subtotal ?? this.subtotal,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      tax: tax ?? this.tax,
      total: total ?? this.total,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      estimatedDeliveryTime: estimatedDeliveryTime ?? this.estimatedDeliveryTime,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      contactNumber: contactNumber ?? this.contactNumber,
    );
  }

  @override
  List<Object?> get props => [
        id,
        restaurant,
        items,
        subtotal,
        deliveryFee,
        tax,
        total,
        status,
        createdAt,
        estimatedDeliveryTime,
        deliveryAddress,
        contactNumber,
      ];
}
