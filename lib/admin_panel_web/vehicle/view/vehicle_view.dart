import 'package:admin_panel_web/admin_panel_web/vehicle/bloc/vehicle_bloc.dart';
import 'package:admin_panel_web/admin_panel_web/vehicle/widget/vehicle_list.dart';
import 'package:admin_panel_web/core/language/lang.dart';
import 'package:admin_panel_web/core/tools/tools_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../core/shared/landk_tab.dart';
import '../../../core/theme/colors/landk_colors.dart';
import '../../../core/theme/fonts/landk_fonts.dart';

class VehicleView extends StatefulWidget {
  const VehicleView({super.key});

  @override
  State<VehicleView> createState() => _VehicleViewState();
}

late VehicleBloc bloc;

class _VehicleViewState extends State<VehicleView>
    with TickerProviderStateMixin {
  late final TabController _controller;

  @override
  void initState() {
    _controller = TabController(length: 2, vsync: this);
    bloc = context.read<VehicleBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, trans(context).vehicle),
      body: SafeArea(
        child: Column(
          children: [
            vSpace(1),
            Align(
              alignment: autoAlignTop(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  trans(context).insertNewVehicle,
                  style: h5,
                ),
              ),
            ),
            vSpace(2),
            Card(
              color: white,
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    landkTab(),
                    Row(
                      children: [
                        SizedBox(
                          width: 20.w,
                          height: 10.h,
                          child: TabBarView(
                            controller: _controller,
                            children: [
                              _inputVehicle(
                                  context,
                                  bloc.nameEn,
                                  AppLocalizations.of(context)!
                                      .typeVehicleName),
                              _inputVehicle(
                                  context,
                                  bloc.nameAr,
                                  AppLocalizations.of(context)!
                                      .typeVehicleName),
                            ],
                          ),
                        ),
                        hSpace(4),
                        _inputVehicle(context, bloc.extraCharges,
                            trans(context).extraCharges)
                      ],
                    ),
                    vSpace(4),
                    Row(
                      children: [
                        _inputVehicle(context, bloc.minimumCoverage,
                            trans(context).minimumCoverage),
                        hSpace(4),
                        _inputVehicle(context, bloc.maximumCoverage,
                            trans(context).maximumCoverage),
                        hSpace(10),
                        Expanded(
                          child: BlocBuilder<VehicleBloc, VehicleState>(
                            builder: (context, state) {
                              return ElevatedButton(
                                onPressed: () {
                                  bloc.add(InsertVehicle());
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: organge,
                                  padding: const EdgeInsets.all(35),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: state == VehicleState.loading
                                    ? loadingWidget()
                                    : Text(
                                        AppLocalizations.of(context)!.save,
                                        style: btnFont!.copyWith(color: white),
                                      ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const _Title(),
            BlocBuilder<VehicleBloc, VehicleState>(
              builder: (context, state) {
                return Expanded(child: VehicleList(vehicles: bloc.vehicles));
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _inputVehicle(BuildContext context, TextEditingController cn, title) {
    return Container(
      width: 20.w,
      height: 10.h,
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(),
      ),
      child: Center(
        child: TextField(
          controller: cn,
          textAlign: TextAlign.center,
          decoration:
              InputDecoration(hintText: title, border: InputBorder.none),
        ),
      ),
    );
  }

  Widget landkTab() {
    return LandkTab(
      controller: _controller,
      tabs: const [
        Tab(
          text: 'English',
        ),
        Tab(
          text: 'Arabic - العربية (AR)',
        ),
      ],
    );
  }
}

class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VehicleBloc, VehicleState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: autoAlignTop(),
            child: Text(
              '${trans(context).vehicle} (${bloc.vehicles.length})',
              style: h5,
            ),
          ),
        );
      },
    );
  }
}
