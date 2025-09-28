import 'package:equatable/equatable.dart';

class FoodItem extends Equatable {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final double price;
  final String category;
  final bool isVegetarian;
  final bool isAvailable;
  final List<String> ingredients;
  final int preparationTime; // in minutes

  const FoodItem({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.category,
    required this.isVegetarian,
    required this.isAvailable,
    required this.ingredients,
    required this.preparationTime,
  });

  factory FoodItem.fromJson(Map<String, dynamic> json) {
    return FoodItem(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
      price: (json['price'] as num).toDouble(),
      category: json['category'] as String,
      isVegetarian: json['isVegetarian'] as bool,
      isAvailable: json['isAvailable'] as bool,
      ingredients: List<String>.from(json['ingredients'] as List),
      preparationTime: json['preparationTime'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'price': price,
      'category': category,
      'isVegetarian': isVegetarian,
      'isAvailable': isAvailable,
      'ingredients': ingredients,
      'preparationTime': preparationTime,
    };
  }

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        imageUrl,
        price,
        category,
        isVegetarian,
        isAvailable,
        ingredients,
        preparationTime,
      ];
}
