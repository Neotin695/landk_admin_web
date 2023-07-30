import 'package:admin_panel_web/core/theme/colors/landk_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sizer/sizer.dart';

import '../../../core/constances/media_const.dart';
import '../../../core/theme/fonts/landk_fonts.dart';
import '../bloc/manage_user_bloc.dart';
import '../repository/manage_user_repository.dart';

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
        rows: widget.customers
            .map(
              (customer) => DataRow(
                cells: [
                  DataCell(
                    CachedNetworkImage(
                      imageUrl: customer.photoUrl,
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
                    Text(customer.email),
                  ),
                  DataCell(
                    Text(customer.phoneNum),
                  ),
                  DataCell(
                    Row(
                      children: [
                        Switch(
                          thumbColor: MaterialStateProperty.all(organge),
                          overlayColor: MaterialStateProperty.all(organge45),
                          trackColor: MaterialStateProperty.all(organge45),
                          value: customer.active,
                          onChanged: (value) {
                            WidgetsBinding.instance.addPostFrameCallback(
                              (timeStamp) {
                                context.read<ManageUserBloc>().add(
                                      ToggleActiveCustomer(
                                        state: value,
                                        uid: customer.id,
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
