import 'package:admin_panel_web/admin_panel_web/vehicle/vehicle_repository/vehicle_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

abstract class _VehicleRepository {
  Future<void> insertVehicle(Vehicle vehicle);

  Either<String, Stream<List<Vehicle>>> fetchAllVehicles();
  Future<Vehicle> fetchVehicle(String id);
  Future<void> deleteVehicle(String id);
  Future<void> updateVehicle(Vehicle vehicle);
  Future<void> toggleStateVehicle(String id, bool state);
}

class VehicleRepository implements _VehicleRepository {
  final FirebaseFirestore _firestore;

  VehicleRepository() : _firestore = FirebaseFirestore.instance;

  @override
  Future<void> deleteVehicle(String id) async {
    await _firestore.collection('vehicles').doc(id).delete();
  }

  @override
  Future<void> insertVehicle(Vehicle vehicle) async {
    final String docId = _firestore.collection('vehicles').doc().id;

    await _firestore
        .collection('vehicles')
        .doc(docId)
        .set(vehicle.copyWith(id: docId).toMap());
  }

  @override
  Future<void> toggleStateVehicle(String id, bool state) async {
    await _firestore.collection('vehicles').doc(id).update({'status': state});
  }

  @override
  Future<void> updateVehicle(Vehicle vehicle) async {
    await _firestore
        .collection('vehicles')
        .doc(vehicle.id)
        .update(vehicle.toMap());
  }

  @override
  Either<String, Stream<List<Vehicle>>> fetchAllVehicles() {
    try {
      return Right(_firestore.collection('vehicles').snapshots().map((event) {
        return event.docs.map((e) => Vehicle.fromMap(e.data())).toList();
      }));
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Vehicle> fetchVehicle(String id) async {
    return Vehicle.fromMap(
        (await _firestore.collection('vehicles').doc(id).get()).data()!);
  }
}
