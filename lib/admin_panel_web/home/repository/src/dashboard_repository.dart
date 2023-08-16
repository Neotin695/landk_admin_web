import 'package:cloud_firestore/cloud_firestore.dart';

import 'model/model.dart';

abstract class _DashboardRepository {
  Future<Analysis> analyseData();
}

class DashboardRepository implements _DashboardRepository {
  final FirebaseFirestore _firestore;

  DashboardRepository() : _firestore = FirebaseFirestore.instance;

  @override
  Future<Analysis> analyseData() async {
    int customers = 0;
    int delegates = 0;
    int products = 0;
    int orders = 0;
    int stors = 0;

    await _firestore.collection('customers').get().then((value) async {
      customers = value.docs.length;
      await _firestore.collection('delegates').get().then((value) async {
        delegates = value.docs.length;
        await _firestore.collection('products').get().then((value) async {
          products = value.docs.length;
          await _firestore.collection('stores').get().then((value) async {
            stors = value.docs.length;
            await _firestore.collection('orders').get().then((value) {
              orders = value.docs.length;
            });
          });
        });
      });
    });

    return Analysis(
      customerCount: customers,
      delegatesCount: delegates,
      productsCount: products,
      storsCount: stors,
      ordersCount: orders,
    );
  }
}
