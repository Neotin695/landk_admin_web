import 'package:equatable/equatable.dart';

import '../../../../../models/model.dart';


// ignore: must_be_immutable
class OrderInfo extends Equatable {
  String id;
  String product;
  int quantity;
  int orderNum;
  String delivery;
  double deliveryPrice;
  bool acceptable;
  AddressInfo location;
  String paymentMethod;
  OrderInfo({
    required this.id,
    required this.product,
    required this.quantity,
    required this.orderNum,
    required this.delivery,
    required this.deliveryPrice,
    required this.acceptable,
    required this.location,
    required this.paymentMethod,
  });

  @override
  List<Object?> get props => [
        id,
        product,
        quantity,
        orderNum,
        delivery,
        deliveryPrice,
        acceptable,
        location,
        paymentMethod
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'product': product,
      'quantity': quantity,
      'orderNum': orderNum,
      'delivery': delivery,
      'deliveryPrice': deliveryPrice,
      'acceptable': acceptable,
      'location': location.toMap(),
      'paymentMethod': paymentMethod,
    };
  }

  factory OrderInfo.fromMap(Map<String, dynamic> map) {
    return OrderInfo(
      id: map['id'] as String,
      product: map['product'] as String,
      quantity: map['quantity'] as int,
      orderNum: map['orderNum'] as int,
      delivery: map['delivery'] as String,
      deliveryPrice: map['deliveryPrice'] as double,
      acceptable: map['acceptable'] as bool,
      location: AddressInfo.fromMap(map['location'] as Map<String, dynamic>),
      paymentMethod: map['paymentMethod'] as String,
    );
  }
}
