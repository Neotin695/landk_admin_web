import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Widget vSpace(double height) => SizedBox(height: height.h);
Widget hSpace(double width) => SizedBox(width: width.h);

Widget loadingWidget() {
  return SizedBox(
      width: 5.w,
      height: 5.h,
      child: const Center(child: CircularProgressIndicator()));
}

SizedBox empty() => const SizedBox();
