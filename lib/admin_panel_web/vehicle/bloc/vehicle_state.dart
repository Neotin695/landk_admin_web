part of 'vehicle_bloc.dart';

abstract class VehicleState extends Equatable {
  const VehicleState();
  
  @override
  List<Object> get props => [];
}

class VehicleInitial extends VehicleState {}
