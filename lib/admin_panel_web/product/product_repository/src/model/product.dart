import 'package:equatable/equatable.dart';

import 'package:admin_panel_web/admin_panel_web/category/repository/category_repository.dart';
import 'package:admin_panel_web/models/reivew.dart';

class Product extends Equatable {
  final String id;
  final String title;
  final String description;
  final String coverUrl;
  final List<String> images;
  final bool soldOut;
  final Category category;
  final double price;
  final int quantity;
  final int discount;
  final List<Reivew> reviews;
  const Product({
    required this.id,
    required this.title,
    required this.description,
    required this.coverUrl,
    required this.images,
    required this.soldOut,
    required this.category,
    required this.price,
    required this.quantity,
    required this.discount,
    required this.reviews,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        coverUrl,
        images,
        soldOut,
        category,
        price,
        quantity,
        discount,
        reviews
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'coverUrl': coverUrl,
      'images': images,
      'soldOut': soldOut,
      'category': category.toMap(),
      'price': price,
      'quantity': quantity,
      'discount': discount,
      'reviews': reviews.map((x) => x.toMap()).toList(),
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      coverUrl: map['coverUrl'] as String,
      images: List<String>.from(map['images'].map((e) => e)),
      soldOut: map['soldOut'] as bool,
      category: Category.fromMap(map['category'] as Map<String, dynamic>),
      price: map['price'] as double,
      quantity: map['quantity'] as int,
      discount: map['discount'] as int,
      reviews: List<Reivew>.from(
        (map['reviews'] as List<int>).map<Reivew>(
          (x) => Reivew.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }
}
