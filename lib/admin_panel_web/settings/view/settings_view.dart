import 'package:admin_panel_web/admin_panel_web/settings/widgets/about_company_view.dart';
import 'package:admin_panel_web/admin_panel_web/settings/widgets/general_settings_view.dart';
import 'package:admin_panel_web/admin_panel_web/settings/widgets/my_account_view.dart';
import 'package:admin_panel_web/core/language/lang.dart';
import 'package:admin_panel_web/core/theme/colors/landk_colors.dart';
import 'package:flutter/material.dart';

class SettingsView extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  final List<bool> isSelected = [true, false, false];
  final List<Widget> pages = [
    const GeneralSettings(),
    const AboutCompany(),
    const MyAccount(),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        customToggleButton(context),
        Expanded(
            child: pages[isSelected.indexWhere((element) => element == true)])
      ],
    );
  }

  Padding customToggleButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      child: ToggleButtons(
        borderColor: organge,
        fillColor: organge,
        textStyle: TextStyle(color: white),
        selectedColor: white,
        borderRadius: BorderRadius.circular(10),
        isSelected: isSelected,
        onPressed: onSelected,
        children: [
          btnItem(context, AppLocalizations.of(context)!.generalSettings),
          btnItem(context, AppLocalizations.of(context)!.myAccount),
          btnItem(context, AppLocalizations.of(context)!.aboutCompany)
        ],
      ),
    );
  }

  Padding btnItem(BuildContext context, title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Text(title),
    );
  }

  void onSelected(newIndex) {
    for (int index = 0; index < isSelected.length; index++) {
      if (index == newIndex) {
        isSelected[index] = true;
      } else {
        isSelected[index] = false;
      }
    }
    setState(() {});
  }
}
