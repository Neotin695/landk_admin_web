import 'package:admin_panel_web/admin_panel_web/manage_user/widget/banned_user_list.dart';
import 'package:admin_panel_web/admin_panel_web/manage_user/widget/users_list.dart';
import 'package:admin_panel_web/core/theme/colors/landk_colors.dart';
import 'package:admin_panel_web/core/theme/fonts/landk_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../core/language/lang.dart';
import '../bloc/manage_user_bloc.dart';

class ManageUserView extends StatefulWidget {
  const ManageUserView({super.key});

  @override
  State<ManageUserView> createState() => _ManageUserViewState();
}

class _ManageUserViewState extends State<ManageUserView>
    with TickerProviderStateMixin {
  late final TabController _controller;

  @override
  void initState() {
    _controller = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.users,
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
              text: AppLocalizations.of(context)!.users,
            ),
            Tab(
              text: AppLocalizations.of(context)!.banned,
            )
          ],
        ),
      ),
      body: BlocListener<ManageUserBloc, ManageUserState>(
        listener: (context, state) {},
        child: SafeArea(
          child: TabBarView(
            controller: _controller,
            children: [
              CustomerList(
                customers:
                    context.select((ManageUserBloc value) => value.customers),
              ),
              BannedList(
                customers:
                    context.select((ManageUserBloc value) => value.customers),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
