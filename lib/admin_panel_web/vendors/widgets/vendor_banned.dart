import 'package:admin_panel_web/admin_panel_web/vendors/bloc/vendors_bloc.dart';
import 'package:admin_panel_web/admin_panel_web/vendors/vendors_repository/src/models/model.dart';
import 'package:admin_panel_web/core/theme/colors/landk_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sizer/sizer.dart';

import '../../../core/constances/media_const.dart';
import '../../../core/theme/fonts/landk_fonts.dart';

// ignore: must_be_immutable
class VendorBanned extends StatefulWidget {
  VendorBanned({super.key, required this.vendors});
  List<Store> vendors;
  @override
  State<VendorBanned> createState() => _VendorBannedState();
}

class _VendorBannedState extends State<VendorBanned> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    widget.vendors = widget.vendors
        .where((e) => e.active == false && e.acceptable == true)
        .toList();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DataTable(
        headingRowColor: MaterialStateProperty.all(grey1),
        dataRowColor: MaterialStateProperty.all(grey2),
        columns: [
          DataColumn(
            tooltip: 'profile photo',
            label: Text(
              AppLocalizations.of(context)!.photo,
              style: h6!.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          DataColumn(
            tooltip: 'display name of user',
            label: Text(
              AppLocalizations.of(context)!.name,
              style: h6!.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          DataColumn(
            tooltip: 'email of user',
            label: Text(
              AppLocalizations.of(context)!.email,
              style: h6!.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          DataColumn(
            tooltip: 'phone number of user',
            label: Text(
              AppLocalizations.of(context)!.phoneNum,
              style: h6!.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          DataColumn(
            tooltip: 'actions want to do',
            label: Text(
              AppLocalizations.of(context)!.actions,
              style: h6!.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ],
        rows: widget.vendors
            .map(
              (customer) => DataRow(
                cells: [
                  DataCell(
                    CachedNetworkImage(
                      imageUrl: customer.logoUrl,
                      width: 4.w,
                      placeholder: (context, url) => SvgPicture.asset(iPerson),
                      errorWidget: (context, url, error) {
                        return SizedBox(
                          height: 10.h,
                          child: SvgPicture.asset(iPerson),
                        );
                      },
                    ),
                  ),
                  DataCell(
                    Text(customer.name),
                  ),
                  DataCell(
                    Text(customer.onwer.email),
                  ),
                  DataCell(
                    Text(customer.onwer.phoneNum),
                  ),
                  DataCell(
                    Row(
                      children: [
                        Switch(
                          thumbColor: MaterialStateProperty.all(organge),
                          overlayColor: MaterialStateProperty.all(organge45),
                          trackColor: MaterialStateProperty.all(organge45),
                          inactiveThumbColor: organge82,
                          value: customer.active,
                          onChanged: (value) {
                            WidgetsBinding.instance.addPostFrameCallback(
                              (timeStamp) {
                                context.read<VendorsBloc>().add(
                                      ToggleVendorState(
                                        state: value,
                                        id: customer.id,
                                      ),
                                    );
                              },
                            );
                            setState(() {});
                          },
                        ),
                        IconButton(
                          onPressed: () {},
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
