import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/vehicle_bloc.dart';
import '../vehicle_repository/vehicle_repository.dart';

class VehiclePage extends StatelessWidget {
  const VehiclePage({super.key, required this.vehicleRepository});

  static Page page() =>
      MaterialPage(child: VehiclePage(vehicleRepository: VehicleRepository()));
  final VehicleRepository vehicleRepository;
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: vehicleRepository,
      child: BlocProvider(
        create: (context) => VehicleBloc(vehicleRepository: vehicleRepository),
        child: Container(),
      ),
    );
  }
}
