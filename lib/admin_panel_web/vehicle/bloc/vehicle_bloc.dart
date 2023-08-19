import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../vehicle_repository/vehicle_repository.dart';

part 'vehicle_event.dart';
part 'vehicle_state.dart';

class VehicleBloc extends Bloc<VehicleEvent, VehicleState> {
  VehicleBloc({required this.vehicleRepository}) : super(VehicleState.initial) {
    on<_FetchAllVehicles>(_fetchVehicles);
    on<InsertVehicle>(_insertVehicle);
    on<DeleteVehicle>(_deleteVehicle);
    on<UpdatetVehicle>(_updateVehicle);
    on<ToggleActiveVehicle>(_toggleActiveVehicle);
    on<FetchOneVehicle>(_fetchOneVehicle);

    _subscription = vehicleRepository.fetchAllVehicles().fold((l) {
      print(l);
      return null;
    }, (r) {
      return r.listen((event) {
        add(_FetchAllVehicles(vehicles: event));
      });
    });
  }

  FutureOr<void> _insertVehicle(event, emit) async {
    if (nameAr.text.isNotEmpty &&
        nameEn.text.isNotEmpty &&
        extraCharges.text.isNotEmpty &&
        minimumCoverage.text.isNotEmpty &&
        maximumCoverage.text.isNotEmpty) {
      emit(VehicleState.loading);
      await vehicleRepository.insertVehicle(
        Vehicle(
          id: '',
          vehicleNameDef: nameAr.text,
          vehicleNameAR: nameAr.text,
          vehicleNameEN: nameEn.text,
          extraCharges: double.parse(extraCharges.text),
          maximumCoverage: double.parse(maximumCoverage.text),
          minimumCoverage: double.parse(minimumCoverage.text),
          status: true,
        ),
      );
    } else {
      emit(VehicleState.failure);
    }
  }

  FutureOr<void> _deleteVehicle(DeleteVehicle event, emit) async {
    emit(VehicleState.loading);
    await vehicleRepository.deleteVehicle(event.id);
    emit(VehicleState.success);
  }

  FutureOr<void> _toggleActiveVehicle(ToggleActiveVehicle event, emit) async {
    emit(VehicleState.loading);
    await vehicleRepository.toggleStateVehicle(event.id, event.state);
    emit(VehicleState.success);
  }

  FutureOr<void> _updateVehicle(UpdatetVehicle event, emit) async {
    emit(VehicleState.loading);
    await vehicleRepository.updateVehicle(event.vehicle);
    emit(VehicleState.success);
  }

  FutureOr<void> _fetchOneVehicle(FetchOneVehicle event, emit) async {
    emit(VehicleState.loadingData);
    vehicle = await vehicleRepository.fetchVehicle(event.id);
    emit(VehicleState.successData);
  }

  FutureOr<void> _fetchVehicles(_FetchAllVehicles event, emit) {
    vehicles = event.vehicles;
    if (vehicles.isNotEmpty) {
      emit(VehicleState.successData);
    }
  }

  final VehicleRepository vehicleRepository;
  StreamSubscription<List<Vehicle>>? _subscription;
  final TextEditingController nameAr = TextEditingController();
  final TextEditingController nameEn = TextEditingController();
  final TextEditingController extraCharges = TextEditingController();
  final TextEditingController maximumCoverage = TextEditingController();
  final TextEditingController minimumCoverage = TextEditingController();

  @override
  Future<void> close() {
    if (_subscription != null) {
      _subscription!.cancel();
    }
    return super.close();
  }

  Vehicle vehicle = Vehicle.empty();
  List<Vehicle> vehicles = [];
}
