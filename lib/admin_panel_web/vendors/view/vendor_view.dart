import 'package:admin_panel_web/admin_panel_web/vendors/widgets/new_vendors.dart';
import 'package:admin_panel_web/admin_panel_web/vendors/widgets/vendor_banned.dart';
import 'package:admin_panel_web/core/theme/colors/landk_colors.dart';
import 'package:admin_panel_web/core/theme/fonts/landk_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../core/language/lang.dart';
import '../bloc/vendors_bloc.dart';
import '../widgets/vendor_list.dart';

class VendorView extends StatefulWidget {
  const VendorView({super.key});

  @override
  State<VendorView> createState() => _VendorViewState();
}

class _VendorViewState extends State<VendorView> with TickerProviderStateMixin {
  late final TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.vendors,
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
              text: AppLocalizations.of(context)!.vendors,
            ),
            Tab(
              text: AppLocalizations.of(context)!.banned,
            ),
            Tab(
              text: AppLocalizations.of(context)!.newVendors,
            )
          ],
        ),
      ),
      body: BlocBuilder<VendorsBloc, VendorsState>(
        builder: (context, state) {
          return SafeArea(
            child: TabBarView(
              controller: _controller,
              children: [
                VendorList(
                  vendors: context.select((VendorsBloc value) => value.vendors),
                ),
                VendorBanned(
                  vendors: context.select((VendorsBloc value) => value.vendors),
                ),
                NewVendors(
                  vendors: context.select((VendorsBloc value) => value.vendors),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
