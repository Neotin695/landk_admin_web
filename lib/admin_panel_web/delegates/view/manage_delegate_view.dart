import 'package:admin_panel_web/admin_panel_web/delegates/widget/new_delegates_list.dart';
import 'package:admin_panel_web/core/theme/colors/landk_colors.dart';
import 'package:admin_panel_web/core/theme/fonts/landk_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../core/language/lang.dart';
import '../bloc/manage_delegates_bloc.dart';
import '../widget/banned_delegates_list.dart';
import '../widget/delegates_list.dart';

class ManageDelegatesView extends StatefulWidget {
  const ManageDelegatesView({super.key});

  @override
  State<ManageDelegatesView> createState() => _ManageDelegatesViewState();
}

class _ManageDelegatesViewState extends State<ManageDelegatesView>
    with TickerProviderStateMixin {
  late final TabController _controller;

  @override
  void initState() {
    _controller = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.delegates,
          style: TextStyle(color: black),
        ),
        backgroundColor: white,
        bottom: TabBar(
          labelStyle: h6!.copyWith(
            fontSize: 4.sp,
          ),
          indicatorColor: organge,
          labelColor: black,
          controller: _controller,
          tabs: [
            Tab(
              text: AppLocalizations.of(context)!.delegates,
            ),
            Tab(
              text: AppLocalizations.of(context)!.banned,
            ),
            Tab(
              text: AppLocalizations.of(context)!.newDelegates,
            )
          ],
        ),
      ),
      body: SafeArea(
        child: TabBarView(
          controller: _controller,
          children: [
            DelegatesList(
              delegates: context
                  .select((ManageDelegatesBloc value) => value.delegates),
            ),
            BannedList(
              delegates: context
                  .select((ManageDelegatesBloc value) => value.delegates),
            ),
            NewDelegatesList(
              delegates: context
                  .select((ManageDelegatesBloc value) => value.delegates),
            ),
          ],
        ),
      ),
    );
  }
}
