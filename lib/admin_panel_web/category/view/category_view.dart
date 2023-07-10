import 'package:admin_panel_web/core/theme/colors/landk_colors.dart';
import 'package:admin_panel_web/core/theme/fonts/landk_fonts.dart';
import 'package:admin_panel_web/core/tools/tools_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sizer/sizer.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        title: Text(
          AppLocalizations.of(context)!.categories,
          style: TextStyle(color: black),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Card(
            color: grey1,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.insertNewCategory,
                    style: h4,
                  ),
                  vSpace(2),
                  _Actions(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _Actions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          width: 15.w,
          height: 10.h,
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(),
          ),
          child: Center(
            child: Expanded(
              child: TextField(
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.typeCategoryName,
                    border: InputBorder.none),
              ),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), border: Border.all()),
          child: _UploadImage(),
        ),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: organge,
            padding: const EdgeInsets.all(40),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(AppLocalizations.of(context)!.saveNewCategory),
        ),
      ],
    );
  }
}

class _UploadImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
            ),
            backgroundColor: organge,
            padding: const EdgeInsets.all(40),
          ),
          child: Text(AppLocalizations.of(context)!.uploadImage),
        ),
        Container(
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: white,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
          ),
          child: const Text(''),
        )
      ],
    );
  }
}
