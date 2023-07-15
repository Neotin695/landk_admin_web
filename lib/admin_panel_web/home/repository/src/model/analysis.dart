import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Analysis extends Equatable {
  int customerCount;
  int delegatesCount;
  int productsCount;
  int storsCount;
  int ordersCount;
  Analysis({
    required this.customerCount,
    required this.delegatesCount,
    required this.productsCount,
    required this.storsCount,
    required this.ordersCount,
  });

  static Analysis empty() => Analysis(
      customerCount: 0,
      delegatesCount: 0,
      productsCount: 0,
      storsCount: 0,
      ordersCount: 0);

  @override
  List<Object?> get props =>
      [customerCount, delegatesCount, productsCount, storsCount, ordersCount];
}
