import 'package:http/http.dart' as http;
import '../models/restaurant.dart';
import '../models/food_item.dart';
import 'restaurant_repository.dart';

class RestaurantRepositoryImpl implements RestaurantRepository {
  final http.Client client;

  RestaurantRepositoryImpl({required this.client});

  @override
  Future<List<Restaurant>> getRestaurants() async {
    try {
      // Simulating API call with mock data
      await Future.delayed(const Duration(seconds: 1));
      return _getMockRestaurants();
    } catch (e) {
      throw Exception('Failed to fetch restaurants: $e');
    }
  }

  @override
  Future<Restaurant> getRestaurantById(String id) async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      final restaurants = _getMockRestaurants();
      final restaurant = restaurants.firstWhere((r) => r.id == id);
      return restaurant;
    } catch (e) {
      throw Exception('Failed to fetch restaurant: $e');
    }
  }

  @override
  Future<List<Restaurant>> searchRestaurants(String query) async {
    try {
      await Future.delayed(const Duration(milliseconds: 800));
      final restaurants = _getMockRestaurants();
      return restaurants
          .where(
            (restaurant) =>
                restaurant.name.toLowerCase().contains(query.toLowerCase()) ||
                restaurant.cuisine.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    } catch (e) {
      throw Exception('Failed to search restaurants: $e');
    }
  }

  List<Restaurant> _getMockRestaurants() {
    return [
      Restaurant(
        id: '1',
        name: 'Burger Palace',
        imageUrl:
            'https://images.unsplash.com/photo-1571091718767-18b5b1457add?w=500',
        cuisine: 'Fast Food',
        rating: 4.5,
        deliveryTime: 25,
        deliveryFee: 49.0,
        isOpen: true,
        menu: [
          const FoodItem(
            id: '1',
            name: 'Classic Burger',
            description:
                'Juicy beef patty with lettuce, tomato, and our special sauce',
            imageUrl:
                'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=300',
            price: 299.0,
            category: 'Burgers',
            isVegetarian: false,
            isAvailable: true,
            ingredients: ['Beef patty', 'Lettuce', 'Tomato', 'Onion', 'Cheese'],
            preparationTime: 15,
          ),
          const FoodItem(
            id: '2',
            name: 'Veggie Burger',
            description: 'Plant-based patty with fresh vegetables and avocado',
            imageUrl:
                'https://images.unsplash.com/photo-1525059696034-4967a729002e?w=300',
            price: 249.0,
            category: 'Burgers',
            isVegetarian: true,
            isAvailable: true,
            ingredients: [
              'Plant patty',
              'Avocado',
              'Lettuce',
              'Tomato',
              'Sprouts',
            ],
            preparationTime: 12,
          ),
          const FoodItem(
            id: '3',
            name: 'Crispy Fries',
            description: 'Golden crispy french fries with sea salt',
            imageUrl:
                'https://images.unsplash.com/photo-1630384060421-cb20d0e0649d?w=300',
            price: 99.0,
            category: 'Sides',
            isVegetarian: true,
            isAvailable: true,
            ingredients: ['Potatoes', 'Salt', 'Oil'],
            preparationTime: 8,
          ),
        ],
      ),
      Restaurant(
        id: '2',
        name: 'Pizza Corner',
        imageUrl:
            'https://images.unsplash.com/photo-1555072956-7758afb20e8a?w=500',
        cuisine: 'Italian',
        rating: 4.7,
        deliveryTime: 35,
        deliveryFee: 39.0,
        isOpen: true,
        menu: [
          const FoodItem(
            id: '4',
            name: 'Margherita Pizza',
            description: 'Traditional pizza with fresh mozzarella and basil',
            imageUrl:
                'https://images.unsplash.com/photo-1604068549290-dea0e4a305ca?w=300',
            price: 399.0,
            category: 'Pizza',
            isVegetarian: true,
            isAvailable: true,
            ingredients: ['Tomato sauce', 'Mozzarella', 'Basil', 'Olive oil'],
            preparationTime: 20,
          ),
          const FoodItem(
            id: '5',
            name: 'Pepperoni Pizza',
            description: 'Classic pizza with pepperoni and melted cheese',
            imageUrl:
                'https://images.unsplash.com/photo-1628840042765-356cda07504e?w=300',
            price: 449.0,
            category: 'Pizza',
            isVegetarian: false,
            isAvailable: true,
            ingredients: ['Tomato sauce', 'Mozzarella', 'Pepperoni'],
            preparationTime: 22,
          ),
        ],
      ),
      Restaurant(
        id: '3',
        name: 'Sushi Express',
        imageUrl:
            'https://images.unsplash.com/photo-1579584425555-c3ce17fd4351?w=500',
        cuisine: 'Japanese',
        rating: 4.8,
        deliveryTime: 30,
        deliveryFee: 59.0,
        isOpen: true,
        menu: [
          const FoodItem(
            id: '6',
            name: 'California Roll',
            description: 'Fresh crab, avocado, and cucumber roll',
            imageUrl:
                'https://images.unsplash.com/photo-1617196034796-73dfa7b1fd56?w=300',
            price: 199.0,
            category: 'Sushi',
            isVegetarian: false,
            isAvailable: true,
            ingredients: ['Crab', 'Avocado', 'Cucumber', 'Nori', 'Rice'],
            preparationTime: 10,
          ),
          const FoodItem(
            id: '7',
            name: 'Salmon Nigiri',
            description: 'Fresh salmon over seasoned sushi rice',
            imageUrl:
                'https://images.unsplash.com/photo-1553621042-f6e147245754?w=300',
            price: 299.0,
            category: 'Sushi',
            isVegetarian: false,
            isAvailable: true,
            ingredients: ['Salmon', 'Sushi rice', 'Wasabi'],
            preparationTime: 8,
          ),
        ],
      ),
    ];
  }
}
