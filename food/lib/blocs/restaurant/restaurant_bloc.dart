import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repositories/restaurant_repository.dart';
import 'restaurant_event.dart';
import 'restaurant_state.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  final RestaurantRepository restaurantRepository;

  RestaurantBloc({required this.restaurantRepository})
      : super(const RestaurantInitial()) {
    on<LoadRestaurants>(_onLoadRestaurants);
    on<SearchRestaurants>(_onSearchRestaurants);
    on<LoadRestaurantDetails>(_onLoadRestaurantDetails);
  }

  Future<void> _onLoadRestaurants(
    LoadRestaurants event,
    Emitter<RestaurantState> emit,
  ) async {
    emit(const RestaurantLoading());
    try {
      final restaurants = await restaurantRepository.getRestaurants();
      emit(RestaurantLoaded(restaurants: restaurants));
    } catch (e) {
      emit(RestaurantError(e.toString()));
    }
  }

  Future<void> _onSearchRestaurants(
    SearchRestaurants event,
    Emitter<RestaurantState> emit,
  ) async {
    emit(const RestaurantLoading());
    try {
      if (event.query.isEmpty) {
        final restaurants = await restaurantRepository.getRestaurants();
        emit(RestaurantLoaded(restaurants: restaurants));
      } else {
        final restaurants = await restaurantRepository.searchRestaurants(event.query);
        emit(RestaurantLoaded(restaurants: restaurants));
      }
    } catch (e) {
      emit(RestaurantError(e.toString()));
    }
  }

  Future<void> _onLoadRestaurantDetails(
    LoadRestaurantDetails event,
    Emitter<RestaurantState> emit,
  ) async {
    try {
      final restaurant = await restaurantRepository.getRestaurantById(event.restaurantId);
      final currentState = state;
      if (currentState is RestaurantLoaded) {
        emit(currentState.copyWith(selectedRestaurant: restaurant));
      } else {
        emit(RestaurantLoaded(restaurants: const [], selectedRestaurant: restaurant));
      }
    } catch (e) {
      emit(RestaurantError(e.toString()));
    }
  }
}
