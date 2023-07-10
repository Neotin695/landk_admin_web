import 'package:admin_panel_web/core/theme/colors/landk_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:manage_user_repository/manage_user_repository.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sizer/sizer.dart';

import '../../../core/constances/media_const.dart';
import '../../../core/theme/fonts/landk_fonts.dart';
import '../bloc/manage_user_bloc.dart';

// ignore: must_be_immutable
class BannedList extends StatefulWidget {
  BannedList({super.key, required this.customers});
  List<Customer> customers;
  @override
  State<BannedList> createState() => _BannedListState();
}

class _BannedListState extends State<BannedList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    widget.customers =
        widget.customers.where((e) => e.active == false).toList();
    return Column(
      children: [
        Card(
          color: grey1,
          elevation: 5,
          child: ListTile(
            leading: Text(
              AppLocalizations.of(context)!.photo,
              style: h6!.copyWith(fontWeight: FontWeight.bold),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  AppLocalizations.of(context)!.name,
                  style: h6!.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  AppLocalizations.of(context)!.email,
                  style: h6!.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  AppLocalizations.of(context)!.phoneNum,
                  style: h6!.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            trailing: Text(
              AppLocalizations.of(context)!.status,
              style: h6!.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        ListView(
          shrinkWrap: true,
          children: widget.customers.map((customer) {
            return Card(
              color: grey2,
              elevation: 2,
              child: ListTile(
                leading: CachedNetworkImage(
                  imageUrl: customer.photoUrl,
                  placeholder: (context, url) => SvgPicture.asset(iPerson),
                  errorWidget: (context, url, error) {
                    return SizedBox(
                        width: 3.w, height: 3.h, child: const Placeholder());
                  },
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(customer.name),
                    Text(customer.email),
                    Text(customer.phoneNum),
                  ],
                ),
                trailing: Switch(
                  value: customer.active,
                  onChanged: (value) {
                    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                      context.read<ManageUserBloc>().add(
                            ToggleActiveCustomer(
                                state: value, uid: customer.id),
                          );
                    });
                    setState(() {});
                  },
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
