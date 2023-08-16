import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'models/model.dart';

abstract class _VendorRepository {
  Future<void> acceptVendor(String id);
  Future<void> rejectVendor(String id);
  Future<void> deleteVendor(String id);
  Stream<Store> fetchVendor(String id);
  Future<void> toggleVendorState(String id, bool state);
  Stream<List<Store>> fetchVendors();
}

class VendorsRepository implements _VendorRepository {
  final FirebaseFirestore _firestore;
  VendorsRepository() : _firestore = FirebaseFirestore.instance;

  @override
  Future<void> acceptVendor(String id) async {
    await _firestore
        .collection('stores')
        .doc(id)
        .update({'acceptable': true, 'active': true});
  }

  @override
  Future<void> deleteVendor(String id) async {
    await _firestore.collection('stores').doc(id).delete();
  }

  @override
  Stream<Store> fetchVendor(String id) {
    return _firestore.collection('stores').doc(id).snapshots().map((event) {
      return Store.fromMap(event.data()!);
    });
  }

  @override
  Stream<List<Store>> fetchVendors() {
    try {
      return _firestore.collection('stores').snapshots().map((event) {
        return event.docs.map((e) => Store.fromMap(e.data())).toList();
      });
    } on FirebaseException catch (e) {
      print(e);
      return Stream.error(e);
    } catch (e) {
      print(e);
      return Stream.error(e);
    }
  }

  @override
  Future<void> rejectVendor(
    String id,
  ) async {
    await _firestore.collection('stores').doc(id).delete();
  }

  @override
  Future<void> toggleVendorState(String id, bool state) async {
    await _firestore.collection('stores').doc(id).update({'active': state});
  }
}
