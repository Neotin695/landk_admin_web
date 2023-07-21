import 'package:equatable/equatable.dart';

import 'package:admin_panel_web/admin_panel_web/category/repository/category_repository.dart';
import 'package:admin_panel_web/admin_panel_web/product/product_repository/src/model/product.dart';
import 'package:admin_panel_web/models/address_info.dart';
import 'package:admin_panel_web/models/id_card.dart';

class Vendor extends Equatable {
  final String id;
  final String userName;
  final String phoneNum;
  final String email;
  final String storName;
  final String logoUrl;
  final IdCard idCard;
  final AddressInfo location;
  final Category category;
  final List<Product> products;
  const Vendor({
    required this.id,
    required this.userName,
    required this.phoneNum,
    required this.email,
    required this.storName,
    required this.logoUrl,
    required this.idCard,
    required this.location,
    required this.category,
    required this.products,
  });

  @override
  List<Object?> get props => [
        id,
        userName,
        phoneNum,
        email,
        storName,
        logoUrl,
        idCard,
        location,
        category,
        products
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userName': userName,
      'phoneNum': phoneNum,
      'email': email,
      'storName': storName,
      'logoUrl': logoUrl,
      'idCard': idCard.toMap(),
      'location': location.toMap(),
      'category': category.toMap(),
      'products': products.map((x) => x.toMap()).toList(),
    };
  }

  factory Vendor.fromMap(Map<String, dynamic> map) {
    return Vendor(
      id: map['id'] as String,
      userName: map['userName'] as String,
      phoneNum: map['phoneNum'] as String,
      email: map['email'] as String,
      storName: map['storName'] as String,
      logoUrl: map['logoUrl'] as String,
      idCard: IdCard.fromMap(map['idCard'] as Map<String, dynamic>),
      location: AddressInfo.fromMap(map['location'] as Map<String, dynamic>),
      category: Category.fromMap(map['category'] as Map<String, dynamic>),
      products: List<Product>.from(
        (map['products'] as List<int>).map<Product>(
          (x) => Product.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }
}
