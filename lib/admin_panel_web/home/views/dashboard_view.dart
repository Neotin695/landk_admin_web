import 'package:admin_panel_web/core/constances/media_const.dart';
import 'package:admin_panel_web/core/language/lang.dart';
import 'package:admin_panel_web/core/theme/colors/landk_colors.dart';
import 'package:admin_panel_web/core/tools/tools_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../bloc/dashboard_bloc.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<DashboardBloc>().add(AnalyseData());
    return Scaffold(
      body: BlocBuilder<DashboardBloc, DashboardStatus>(
        builder: (context, state) {
          if (state == DashboardStatus.loading) {
            return loadingWidget();
          } else if (state == DashboardStatus.success) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
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
      child: Column(
        children: [
          SvgPicture.asset(icon),
          Text('$count'),
          Text(label),
        ],
      ),
    );
  }
}
