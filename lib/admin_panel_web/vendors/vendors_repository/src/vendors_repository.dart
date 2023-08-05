import 'package:cloud_firestore/cloud_firestore.dart';

import 'models/model.dart';

abstract class _VendorRepository {
  Future<void> acceptVendor(String id);
  Future<void> rejectVendor(String id);
  Future<void> deleteVendor(String id);
  Stream<Vendor> fetchVendor(String id);
  Future<void> toggleVendorState(String id, bool state);
  Stream<List<Vendor>> fetchVendors();
}

class VendorsRepository implements _VendorRepository {
  final FirebaseFirestore _firestore;
  VendorsRepository() : _firestore = FirebaseFirestore.instance;

  @override
  Future<void> acceptVendor(String id) async {
    await _firestore.collection('vendors').doc(id).update({'acceptable': true});
  }

  @override
  Future<void> deleteVendor(String id) async {
    await _firestore.collection('vendors').doc(id).delete();
  }

  @override
  Stream<Vendor> fetchVendor(String id) {
    return _firestore.collection('vendors').doc(id).snapshots().map((event) {
      return Vendor.fromMap(event.data()!);
    });
  }

  @override
  Stream<List<Vendor>> fetchVendors() {
    return _firestore.collection('vendors').snapshots().map((event) {
      return event.docs.map((e) => Vendor.fromMap(e.data())).toList();
    });
  }

  @override
  Future<void> rejectVendor(
    String id,
  ) async {
    await _firestore.collection('vendors').doc(id).delete();
  }

  @override
  Future<void> toggleVendorState(String id, bool state) async {
    await _firestore.collection('vendors').doc(id).update({'statuc': state});
  }
}
