import 'package:admin_panel_web/core/constances/media_const.dart';
import 'package:admin_panel_web/core/language/lang.dart';
import 'package:admin_panel_web/core/theme/colors/landk_colors.dart';
import 'package:admin_panel_web/core/theme/fonts/landk_fonts.dart';
import 'package:admin_panel_web/core/tools/tools_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../bloc/dashboard_bloc.dart';

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
          } else if (state == DashboardStatus.success) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _DashboardCard(
                        label: AppLocalizations.of(context)!.users,
                        count: context.select((DashboardBloc value) =>
                            value.analysis.customerCount),
                        icon: iCandidates,
                      ),
                      _DashboardCard(
                        label: AppLocalizations.of(context)!.stors,
                        count: context.select(
                            (DashboardBloc value) => value.analysis.storsCount),
                        icon: istores,
                      ),
                      _DashboardCard(
                        label: AppLocalizations.of(context)!.delegates,
                        count: context.select((DashboardBloc value) =>
                            value.analysis.delegatesCount),
                        icon: iDelivery,
                      ),
                    ],
                  ),
                  Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _DashboardCard(
                        label: AppLocalizations.of(context)!.order,
                        count: context.select((DashboardBloc value) =>
                            value.analysis.productsCount),
                        icon: iOrders,
                      ),
                      _DashboardCard(
                        label: AppLocalizations.of(context)!.products,
                        count: context.select((DashboardBloc value) =>
                            value.analysis.ordersCount),
                        icon: iProducts,
                      ),
                    ],
                  ),
                ],
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

class _DashboardCard extends StatelessWidget {
  const _DashboardCard({
    required this.label,
    required this.icon,
    required this.count,
  });

  final String label;
  final String icon;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: organge45,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: SizedBox(
        width: 25.w,
        height: 25.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(
                icon,
                width: 8.w,
                height: 8.h,
              ),
            ),
            Text(
              '$count',
              style: h5!.copyWith(fontSize: 5.sp, fontWeight: FontWeight.bold),
            ),
            Text(
              label,
              style: h5!.copyWith(fontSize: 5.sp, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
