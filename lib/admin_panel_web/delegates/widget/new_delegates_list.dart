import 'package:admin_panel_web/core/theme/colors/landk_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sizer/sizer.dart';

import '../../../core/constances/media_const.dart';
import '../../../core/theme/fonts/landk_fonts.dart';
import '../bloc/manage_delegates_bloc.dart';
import '../repository/src/model/delegate.dart';

// ignore: must_be_immutable
class NewDelegatesList extends StatefulWidget {
  NewDelegatesList({super.key, required this.delegates});
  List<Delegate> delegates;
  @override
  State<NewDelegatesList> createState() => _NewDelegatesListState();
}

class _NewDelegatesListState extends State<NewDelegatesList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    widget.delegates = widget.delegates
        .where((e) => e.acceptable == false && e.active == false)
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
              (delegates) => DataRow(
                cells: [
                  DataCell(
                    CachedNetworkImage(
                      fit: BoxFit.cover,
                      width: 5.w,
                      height: 5.h,
                      imageUrl: delegates.photoUrl,
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
                    Text(delegates.name),
                  ),
                  DataCell(
                    Text(delegates.email),
                  ),
                  DataCell(
                    Text(delegates.phoneNum),
                  ),
                  DataCell(
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.delete,
                            color: red,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            context
                                .read<ManageDelegatesBloc>()
                                .add(AccepteDelegate(uid: delegates.id));
                          },
                          icon: Icon(
                            Icons.check,
                            color: green,
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
