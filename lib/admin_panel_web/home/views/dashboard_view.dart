import 'package:admin_panel_web/core/constances/media_const.dart';
import 'package:admin_panel_web/core/language/lang.dart';
import 'package:admin_panel_web/core/tools/tools_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/dashboard_bloc.dart';
import '../widgets/dashboard_card.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    //context.read<DashboardBloc>().add(AnalyseData());
    return Scaffold(
      appBar: customAppBar(context, AppLocalizations.of(context)!.dashBoard),
      body: BlocBuilder<DashboardBloc, DashboardStatus>(
        builder: (context, state) {
          if (state == DashboardStatus.loading) {
            return Center(child: loadingWidget());
          } else if (state == DashboardStatus.success ||
              state == DashboardStatus.initial) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //    Container(
                    //   padding: const EdgeInsets.all(10),
                    //   child: Text(trans(context).),
                    // ),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        DashboardCard(
                          label: AppLocalizations.of(context)!.earn,
                          count: context.select((DashboardBloc value) =>
                              value.analysis.totalEarn),
                          icon: iEarn,
                        ),
                        DashboardCard(
                          label: AppLocalizations.of(context)!.users,
                          count: context.select((DashboardBloc value) =>
                              value.analysis.customerCount),
                          icon: iCandidates,
                        ),
                        DashboardCard(
                          label: AppLocalizations.of(context)!.stors,
                          count: context.select((DashboardBloc value) =>
                              value.analysis.storsCount),
                          icon: istores,
                        ),
                        DashboardCard(
                          label: AppLocalizations.of(context)!.delegates,
                          count: context.select((DashboardBloc value) =>
                              value.analysis.delegatesCount),
                          icon: iDelivery,
                        ),
                      ],
                    ),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        DashboardCard(
                          label: AppLocalizations.of(context)!.order,
                          count: context.select((DashboardBloc value) =>
                              value.analysis.productsCount),
                          icon: iOrders,
                        ),
                        DashboardCard(
                          label: AppLocalizations.of(context)!.products,
                          count: context.select((DashboardBloc value) =>
                              value.analysis.ordersCount),
                          icon: iProducts,
                        ),
                      ],
                    ),
                    vSpace(10),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        DashboardCard(
                          label: AppLocalizations.of(context)!.orderPlaced,
                          count: context.select((DashboardBloc value) =>
                              value.analysis.orderPlaced),
                          icon: iOrderPlaced,
                        ),
                        DashboardCard(
                          label: AppLocalizations.of(context)!.orderConfirmed,
                          count: context.select((DashboardBloc value) =>
                              value.analysis.orderConfirmed),
                          icon: iOrderConfirm,
                        ),
                        DashboardCard(
                          label: AppLocalizations.of(context)!.orderShipped,
                          count: context.select((DashboardBloc value) =>
                              value.analysis.orderShapped),
                          icon: iOrderShipped,
                        ),
                        DashboardCard(
                          label: AppLocalizations.of(context)!.orderCompleted,
                          count: context.select((DashboardBloc value) =>
                              value.analysis.orderCompleted),
                          icon: iOrderCompleted,
                        ),
                      ],
                    ),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        DashboardCard(
                          label: AppLocalizations.of(context)!.orderCanceled,
                          count: context.select((DashboardBloc value) =>
                              value.analysis.orderCanceled),
                          icon: iOrderCanceled,
                        ),
                        DashboardCard(
                          label: AppLocalizations.of(context)!.deliveryFailed,
                          count: context.select((DashboardBloc value) =>
                              value.analysis.deliveryFailed),
                          icon: iDeliverFailed,
                        ),
                        DashboardCard(
                          label: AppLocalizations.of(context)!.waitingDriver,
                          count: context.select((DashboardBloc value) =>
                              value.analysis.waitingForDriver),
                          icon: iWaitingDriver,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          } else {
            return empty();
          }
        },
      ),
    );
  }
}
