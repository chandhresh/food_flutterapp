import '../models/order.dart';

abstract class OrderRepository {
  Future<Order> createOrder(Order order);
  Future<Order> getOrderById(String id);
  Future<List<Order>> getUserOrders();
  Future<Order> updateOrderStatus(String orderId, OrderStatus status);
}
