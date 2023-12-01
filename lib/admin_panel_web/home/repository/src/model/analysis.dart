// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Analysis extends Equatable {
  int customerCount;
  int delegatesCount;
  int productsCount;
  int storsCount;
  int ordersCount;
  double totalEarn;
  int orderPlaced;
  int orderConfirmed;
  int orderShapped;
  int orderCompleted;
  int orderCanceled;
  int deliveryFailed;
  int waitingForDriver;
  Analysis({
    required this.customerCount,
    required this.delegatesCount,
    required this.productsCount,
    required this.storsCount,
    required this.ordersCount,
    required this.totalEarn,
    required this.orderPlaced,
    required this.orderConfirmed,
    required this.orderShapped,
    required this.orderCompleted,
    required this.orderCanceled,
    required this.deliveryFailed,
    required this.waitingForDriver,
  });

  static Analysis empty() => Analysis(
        customerCount: 0,
        delegatesCount: 0,
        productsCount: 0,
        storsCount: 0,
        totalEarn: 0,
        ordersCount: 0,
        orderCanceled: 0,
        orderCompleted: 0,
        orderConfirmed: 0,
        orderPlaced: 0,
        orderShapped: 0,
        deliveryFailed: 0,
        waitingForDriver: 0,
      );

  @override
  List<Object> get props {
    return [
      customerCount,
      delegatesCount,
      productsCount,
      storsCount,
      ordersCount,
      totalEarn,
      orderPlaced,
      orderConfirmed,
      orderShapped,
      orderCompleted,
      orderCanceled,
      deliveryFailed,
      waitingForDriver,
    ];
  }
}
