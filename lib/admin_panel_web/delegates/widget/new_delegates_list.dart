import 'package:admin_panel_web/core/theme/colors/landk_colors.dart';
import 'package:admin_panel_web/core/tools/tools_widget.dart';
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
    widget.delegates =
        widget.delegates.where((e) => e.acceptable == false).toList();
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
          children: widget.delegates.map((delegate) {
            return Card(
              color: grey2,
              elevation: 2,
              child: ListTile(
                contentPadding: const EdgeInsets.all(20),
                leading: CachedNetworkImage(
                  imageUrl: delegate.photoUrl,
                  placeholder: (context, url) => SvgPicture.asset(iPerson),
                  errorWidget: (context, url, error) {
                    return SizedBox(
                        width: 10.w,
                        height: 10.h,
                        child: SvgPicture.asset(iPerson));
                  },
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(delegate.name),
                    Text(delegate.email),
                    Text(delegate.phoneNum),
                  ],
                ),
                trailing:
                    BlocBuilder<ManageDelegatesBloc, ManageDelegatesStatus>(
                  builder: (context, state) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: organge,
                          padding: const EdgeInsets.all(15)),
                      onPressed: () {
                        context.read<ManageDelegatesBloc>().add(
                              AccepteDelegate(state: true, uid: delegate.id),
                            );
                      },
                      child: state == ManageDelegatesStatus.loading
                          ? loadingWidget()
                          : Text(
                              AppLocalizations.of(context)!.accept,
                              style: btnFont,
                            ),
                    );
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
