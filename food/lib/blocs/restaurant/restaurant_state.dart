import 'package:equatable/equatable.dart';
import '../../models/restaurant.dart';

abstract class RestaurantState extends Equatable {
  const RestaurantState();

  @override
  List<Object> get props => [];
}

class RestaurantInitial extends RestaurantState {
  const RestaurantInitial();
}

class RestaurantLoading extends RestaurantState {
  const RestaurantLoading();
}

class RestaurantLoaded extends RestaurantState {
  final List<Restaurant> restaurants;
  final Restaurant? selectedRestaurant;

  const RestaurantLoaded({required this.restaurants, this.selectedRestaurant});

  RestaurantLoaded copyWith({
    List<Restaurant>? restaurants,
    Restaurant? selectedRestaurant,
  }) {
    return RestaurantLoaded(
      restaurants: restaurants ?? this.restaurants,
      selectedRestaurant: selectedRestaurant ?? this.selectedRestaurant,
    );
  }

  @override
  List<Object> get props => [restaurants, selectedRestaurant ?? ''];
}

class RestaurantError extends RestaurantState {
  final String message;

  const RestaurantError(this.message);

  @override
  List<Object> get props => [message];
}
