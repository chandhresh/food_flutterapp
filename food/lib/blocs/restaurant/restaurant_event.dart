import 'package:equatable/equatable.dart';

abstract class RestaurantEvent extends Equatable {
  const RestaurantEvent();

  @override
  List<Object> get props => [];
}

class LoadRestaurants extends RestaurantEvent {
  const LoadRestaurants();
}

class SearchRestaurants extends RestaurantEvent {
  final String query;

  const SearchRestaurants(this.query);

  @override
  List<Object> get props => [query];
}

class LoadRestaurantDetails extends RestaurantEvent {
  final String restaurantId;

  const LoadRestaurantDetails(this.restaurantId);

  @override
  List<Object> get props => [restaurantId];
}
