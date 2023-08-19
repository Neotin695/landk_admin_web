import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../language/lang.dart';
import '../services/common.dart';
import '../theme/colors/landk_colors.dart';

Widget vSpace(double height) => SizedBox(height: height.h);
Widget hSpace(double width) => SizedBox(width: width.h);

Widget loadingWidget() {
  return SizedBox(
      width: 5.w,
      height: 5.h,
      child: const Center(child: CircularProgressIndicator()));
}

Alignment autoAlignTop() {
  return locale() ? Alignment.topRight : Alignment.topLeft;
}

AppLocalizations trans(BuildContext context) => AppLocalizations.of(context)!;

Alignment autoAlignCenter() {
  return locale() ? Alignment.centerRight : Alignment.centerLeft;
}

Alignment autoAlignBottom() {
  return locale() ? Alignment.bottomRight : Alignment.bottomRight;
}

bool locale() => Common.prefs.getString('locale')! == 'ar';
SizedBox empty() => const SizedBox();

AppBar customAppBar(BuildContext context, title) {
  return AppBar(
    backgroundColor: white,
    title: Text(
      title,
      style: TextStyle(color: black),
    ),
    centerTitle: true,
  );
}
