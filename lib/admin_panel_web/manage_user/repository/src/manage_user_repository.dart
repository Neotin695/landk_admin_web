import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import 'model/model.dart';

abstract class _ManageUser {
  Future<void> toggleActiveCustomer(String id, bool state);
  Future<void> deleteCustomer(String id);
  Either<String, Stream<List<Customer>>> fetchAllCustomers();
  Future<Customer> fetchCustomer(String id);
  Future<void> searchCustomer(String query);
}

class ManageUserRepository implements _ManageUser {
  final FirebaseFirestore _fireStore;

  ManageUserRepository() : _fireStore = FirebaseFirestore.instance;

  @override
  Future<void> deleteCustomer(String id) async {
    await _fireStore.collection('customers').doc(id).delete();
  }

  @override
  Future<Customer> fetchCustomer(String id) async {
    return Customer.fromMap(
      ((await _fireStore.collection('customers').doc(id).get()).data()
          as Map<String, dynamic>),
    );
  }

  @override
  Either<String, Stream<List<Customer>>> fetchAllCustomers() {
    try {
      return Right(_fireStore.collection('customers').snapshots().map(
        (event) {
          return event.docs.map((e) => Customer.fromMap(e.data())).toList();
        },
      ));
    } catch (er) {
      return Left(er.toString());
    }
  }

  @override
  Future<void> searchCustomer(String query) async {}

  @override
  Future<void> toggleActiveCustomer(String id, bool state) async {
    try {
      await _fireStore
          .collection('customers')
          .doc(id)
          .update({'active': state});
    } catch (e) {
      print(e);
    }
  }
}
