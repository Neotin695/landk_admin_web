import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../core/constances/media_const.dart';
import '../../../core/theme/colors/landk_colors.dart';
import '../../../core/theme/fonts/landk_fonts.dart';
import '../bloc/manage_delegates_bloc.dart';
import '../repository/manage_user_repository.dart';

// ignore: must_be_immutable
class DelegatesList extends StatefulWidget {
  DelegatesList({super.key, required this.delegates});

  List<Delegate> delegates;

  @override
  State<DelegatesList> createState() => _DelegatesListState();
}

class _DelegatesListState extends State<DelegatesList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    widget.delegates = widget.delegates
        .where((e) => e.active == true && e.acceptable == true)
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
        rows: widget.delegates
            .map(
              (delegate) => DataRow(
                cells: [
                  DataCell(
                    CachedNetworkImage(
                      imageUrl: delegate.photoUrl,
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
                    Text(delegate.name),
                  ),
                  DataCell(
                    Text(delegate.email),
                  ),
                  DataCell(
                    Text(delegate.phoneNum),
                  ),
                  DataCell(
                    Row(
                      children: [
                        Switch(
                          thumbColor: MaterialStateProperty.all(organge),
                          overlayColor: MaterialStateProperty.all(organge45),
                          trackColor: MaterialStateProperty.all(organge45),
                          value: delegate.active,
                          onChanged: (value) {
                            WidgetsBinding.instance.addPostFrameCallback(
                              (timeStamp) {
                                context.read<ManageDelegatesBloc>().add(
                                      ToggleActiveDelegate(
                                        state: value,
                                        uid: delegate.id,
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
