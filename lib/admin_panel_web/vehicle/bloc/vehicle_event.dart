// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'vehicle_bloc.dart';

abstract class VehicleEvent extends Equatable {
  const VehicleEvent();

  @override
  List<Object> get props => [];
}

class _FetchAllVehicles extends VehicleEvent {
  final List<Vehicle> vehicles;
  const _FetchAllVehicles({
    required this.vehicles,
  });
}

class InsertVehicle extends VehicleEvent {}

class DeleteVehicle extends VehicleEvent {
  final String id;
  const DeleteVehicle({
    required this.id,
  });
}

class FetchOneVehicle extends VehicleEvent {
  final String id;
  const FetchOneVehicle({
    required this.id,
  });
}

class ToggleActiveVehicle extends VehicleEvent {
  final String id;
  final bool state;
  const ToggleActiveVehicle({
    required this.id,
    required this.state,
  });
}

class UpdatetVehicle extends VehicleEvent {
  final String id;
  final Vehicle vehicle;
  const UpdatetVehicle({required this.id, required this.vehicle});
}
