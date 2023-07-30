import 'package:cloud_firestore/cloud_firestore.dart';

import 'models/model.dart';

abstract class _VendorRepository {
  Future<void> acceptVendor(String id);
  Future<void> rejectVendor(String id, String message);
  Future<void> deleteVendor(String id);
  Future<void> fetchVendor(String id);
  Future<void> toggleActiveVendor(String id, bool state);
  Stream<Vendor> fetchVendors();
}

class VendorsRepository implements _VendorRepository {
  final FirebaseFirestore _firestore;
  VendorsRepository() : _firestore = FirebaseFirestore.instance;

  @override
  Future<void> acceptVendor(String id) {
    // TODO: implement acceptVendor
    throw UnimplementedError();
  }

  @override
  Future<void> deleteVendor(String id) {
    // TODO: implement deleteVendor
    throw UnimplementedError();
  }

  @override
  Future<void> fetchVendor(String id) {
    // TODO: implement fetchVendor
    throw UnimplementedError();
  }

  @override
  Stream<Vendor> fetchVendors() {
    // TODO: implement fetchVendors
    throw UnimplementedError();
  }

  @override
  Future<void> rejectVendor(String id, String message) {
    // TODO: implement rejectVendor
    throw UnimplementedError();
  }

  @override
  Future<void> toggleActiveVendor(String id, bool state) {
    // TODO: implement toggleActiveVendor
    throw UnimplementedError();
  }
}
