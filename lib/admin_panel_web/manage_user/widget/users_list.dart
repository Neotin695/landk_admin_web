import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../core/constances/media_const.dart';
import '../../../core/theme/colors/landk_colors.dart';
import '../../../core/theme/fonts/landk_fonts.dart';
import '../bloc/manage_user_bloc.dart';
import '../repository/manage_user_repository.dart';

// ignore: must_be_immutable
class CustomerList extends StatefulWidget {
  CustomerList({super.key, required this.customers});

  List<Customer> customers;

  @override
  State<CustomerList> createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    widget.customers = widget.customers.where((e) => e.active == true).toList();
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
                      width: 3.w,
                      height: 3.h,
                      child: const Placeholder(),
                    );
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