import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../vehicle_repository/vehicle_repository.dart';

part 'vehicle_event.dart';
part 'vehicle_state.dart';

class VehicleBloc extends Bloc<VehicleEvent, VehicleState> {
  VehicleBloc({required this.vehicleRepository}) : super(VehicleInitial()) {
    on<VehicleEvent>((event, emit) {
      // TODO: implement event handler
    });
  }

  final VehicleRepository vehicleRepository;
}
