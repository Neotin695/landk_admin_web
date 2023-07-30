import 'package:admin_panel_web/core/language/lang.dart';
import 'package:admin_panel_web/core/theme/colors/landk_colors.dart';
import 'package:admin_panel_web/core/tools/tools_widget.dart';
import 'package:flutter/material.dart';

import '../../../core/services/common.dart';
import '../../../core/theme/fonts/landk_fonts.dart';
import '../../app/views/app.dart';

class GeneralSettings extends StatefulWidget {
  const GeneralSettings({super.key});

  @override
  State<GeneralSettings> createState() => _GeneralSettingsState();
}

class _GeneralSettingsState extends State<GeneralSettings> {
  String currentLocale = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          hSpace(5),
          _langDropdown(context),
          hSpace(2),
          _copyRight(context),
          hSpace(3),
          _saveBtn(context),
        ],
      ),
    );
  }

  ElevatedButton _saveBtn(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        await Common.prefs.setString('locale', currentLocale).then(
              (value) => AppView.restartApp(context),
            );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: organge,
        padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 25),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(
        AppLocalizations.of(context)!.save,
        style: btnFont!.copyWith(color: white),
      ),
    );
  }

  Container _copyRight(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: grey1, width: 2),
      ),
      child: Text(
        '${AppLocalizations.of(context)!.landk} 2022/2023',
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Container _langDropdown(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: grey1, width: 2),
      ),
      child: DropdownButton(
        hint: Text(
          currentLocale.isEmpty
              ? locale()
                  ? 'العربية'
                  : 'English'
              : currentLocale == 'ar'
                  ? 'العربية'
                  : 'English',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        alignment: autoAlignCenter(),
        underline: empty(),
        padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 5),
        items: const [
          DropdownMenuItem(value: 'ar', child: Text('العربية')),
          DropdownMenuItem(value: 'en', child: Text('English')),
        ],
        onChanged: (value) async {
          currentLocale = value!;
          setState(() {});
        },
      ),
    );
  }
}
