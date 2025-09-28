import 'dart:math';
import '../models/order.dart';
import 'order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final List<Order> _orders = [];

  @override
  Future<Order> createOrder(Order order) async {
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // Simulate random success/failure for error handling demonstration
      if (Random().nextInt(10) < 1) { // 10% failure rate
        throw Exception('Payment processing failed');
      }

      _orders.add(order);
      return order;
    } catch (e) {
      throw Exception('Failed to create order: $e');
    }
  }

  @override
  Future<Order> getOrderById(String id) async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      final order = _orders.firstWhere((o) => o.id == id);
      return order;
    } catch (e) {
      throw Exception('Order not found: $e');
    }
  }

  @override
  Future<List<Order>> getUserOrders() async {
    try {
      await Future.delayed(const Duration(milliseconds: 800));
      return List.from(_orders);
    } catch (e) {
      throw Exception('Failed to fetch orders: $e');
    }
  }

  @override
  Future<Order> updateOrderStatus(String orderId, OrderStatus status) async {
    try {
      await Future.delayed(const Duration(milliseconds: 300));
      final orderIndex = _orders.indexWhere((o) => o.id == orderId);
      if (orderIndex != -1) {
        _orders[orderIndex] = _orders[orderIndex].copyWith(status: status);
        return _orders[orderIndex];
      }
      throw Exception('Order not found');
    } catch (e) {
      throw Exception('Failed to update order status: $e');
    }
  }
}
