import 'package:admin_panel_web/admin_panel_web/vehicle/bloc/vehicle_bloc.dart';
import 'package:admin_panel_web/admin_panel_web/vehicle/vehicle_repository/vehicle_repository.dart';
import 'package:admin_panel_web/core/tools/tools_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/theme/colors/landk_colors.dart';
import '../../../core/theme/fonts/landk_fonts.dart';

// ignore: must_be_immutable
class VehicleList extends StatefulWidget {
  VehicleList({super.key, required this.vehicles});

  List<Vehicle> vehicles;

  @override
  State<VehicleList> createState() => _VehicleListState();
}

class _VehicleListState extends State<VehicleList> {
  late final VehicleBloc bloc;
  @override
  void initState() {
    bloc = context.read<VehicleBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DataTable(
        headingRowColor: MaterialStateProperty.all(grey1),
        dataRowColor: MaterialStateProperty.all(grey2),
        columns: [
          DataColumn(
            onSort: (index, state) {},
            label: Text(
              trans(context).status,
              style: h6!.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          DataColumn(
            onSort: (index, state) {},
            label: Text(
              trans(context).name,
              style: h6!.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          DataColumn(
            label: Text(
              trans(context).extraCharges,
              style: h6!.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          DataColumn(
            label: Text(
              trans(context).minimumCoverage,
              style: h6!.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          DataColumn(
            label: Text(
              trans(context).maximumCoverage,
              style: h6!.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          DataColumn(
            label: Text(
              trans(context).actions,
              style: h6!.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ],
        rows: widget.vehicles
            .map(
              (vehicle) => DataRow(
                cells: [
                  DataCell(Text(vehicle.status
                      ? trans(context).active
                      : trans(context).disable)),
                  DataCell(
                    Text(locale()
                        ? vehicle.vehicleNameAR
                        : vehicle.vehicleNameEN),
                  ),
                  DataCell(
                    Text(vehicle.extraCharges.toString()),
                  ),
                  DataCell(
                    Text(vehicle.minimumCoverage.toString()),
                  ),
                  DataCell(
                    Text(vehicle.maximumCoverage.toString()),
                  ),
                  DataCell(
                    Row(
                      children: [
                        Switch(
                          thumbColor: MaterialStateProperty.all(organge),
                          overlayColor: MaterialStateProperty.all(organge45),
                          trackColor: MaterialStateProperty.all(organge45),
                          value: vehicle.status,
                          onChanged: (value) {
                            WidgetsBinding.instance.addPostFrameCallback(
                              (timeStamp) {
                                bloc.add(
                                  ToggleActiveVehicle(
                                    state: value,
                                    id: vehicle.id,
                                  ),
                                );
                              },
                            );
                            setState(() {});
                          },
                        ),
                        IconButton(
                          onPressed: () {
                            bloc.add(DeleteVehicle(id: vehicle.id));
                          },
                          icon: Icon(
                            Icons.delete,
                            color: red,
                          ),
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: SvgPicture.asset('assets/icons/eye.svg')),
                      ],
                    ),
                  )
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}
