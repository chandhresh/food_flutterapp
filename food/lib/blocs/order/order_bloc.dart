import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../../models/order.dart';
import '../../repositories/order_repository.dart';
import 'order_event.dart';
import 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepository orderRepository;
  final Uuid _uuid = const Uuid();

  OrderBloc({required this.orderRepository}) : super(const OrderInitial()) {
    on<PlaceOrder>(_onPlaceOrder);
    on<LoadOrderDetails>(_onLoadOrderDetails);
    on<UpdateOrderStatus>(_onUpdateOrderStatus);
  }

  Future<void> _onPlaceOrder(
    PlaceOrder event,
    Emitter<OrderState> emit,
  ) async {
    emit(const OrderPlacing());
    try {
      final order = Order.fromCart(
        id: _uuid.v4(),
        restaurant: event.restaurant,
        items: event.items,
        deliveryAddress: event.deliveryAddress,
        contactNumber: event.contactNumber,
      );

      final createdOrder = await orderRepository.createOrder(order);
      emit(OrderPlaced(createdOrder));
    } catch (e) {
      emit(OrderError(e.toString()));
    }
  }

  Future<void> _onLoadOrderDetails(
    LoadOrderDetails event,
    Emitter<OrderState> emit,
  ) async {
    emit(const OrderLoading());
    try {
      final order = await orderRepository.getOrderById(event.orderId);
      emit(OrderLoaded(order));
    } catch (e) {
      emit(OrderError(e.toString()));
    }
  }

  Future<void> _onUpdateOrderStatus(
    UpdateOrderStatus event,
    Emitter<OrderState> emit,
  ) async {
    try {
      final updatedOrder = await orderRepository.updateOrderStatus(
        event.orderId,
        event.status,
      );
      emit(OrderLoaded(updatedOrder));
    } catch (e) {
      emit(OrderError(e.toString()));
    }
  }
}
