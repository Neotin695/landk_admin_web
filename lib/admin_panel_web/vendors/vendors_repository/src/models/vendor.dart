// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:admin_panel_web/admin_panel_web/category/repository/category_repository.dart';
import 'package:admin_panel_web/admin_panel_web/product/product_repository/src/model/product.dart';
import 'package:admin_panel_web/admin_panel_web/vendors/vendors_repository/src/models/onwer.dart';
import 'package:admin_panel_web/models/address_info.dart';
import 'package:admin_panel_web/models/id_card.dart';

class Vendor extends Equatable {
  final String id;
  final Onwer onwer;
  final String storName;
  final String logoUrl;
  final IdCard idCard;
  final AddressInfo location;
  final Category category;
  final List<Product> products;
  final bool status;
  final bool acceptable;
  const Vendor({
    required this.id,
    required this.onwer,
    required this.storName,
    required this.logoUrl,
    required this.idCard,
    required this.location,
    required this.category,
    required this.status,
    required this.products,
    required this.acceptable,
  });

  static Vendor empty() => Vendor(
      id: '',
      onwer: Onwer.empty(),
      storName: '',
      status: false,
      logoUrl: '',
      idCard: IdCard.empty(),
      location: AddressInfo.empty(),
      category: Category.empty(),
      acceptable: false,
      products: const []);

  @override
  List<Object?> get props =>
      [id, onwer, storName, logoUrl, idCard, location, category, products];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'onwer': onwer.toMap(),
      'storName': storName,
      'status': status,
      'logoUrl': logoUrl,
      'acceptable': acceptable,
      'idCard': idCard.toMap(),
      'location': location.toMap(),
      'category': category.toMap(),
      'products': products.map((x) => x.toMap()).toList(),
    };
  }

  factory Vendor.fromMap(Map<String, dynamic> map) {
    return Vendor(
      id: map['id'] as String,
      onwer: Onwer.fromMap(map['onwer'] as Map<String, dynamic>),
      storName: map['storName'] as String,
      status: map['status'] as bool,
      acceptable: map['acceptable'] as bool,
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
