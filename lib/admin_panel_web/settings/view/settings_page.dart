import 'package:admin_panel_web/admin_panel_web/settings/view/settings_view.dart';
import 'package:admin_panel_web/core/language/lang.dart';
import 'package:flutter/material.dart';

import '../../../core/tools/tools_widget.dart';

class SettingsPage extends StatelessWidget {
  static Page page() => const MaterialPage(child: SettingsPage());
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, AppLocalizations.of(context)!.settings),
      body: SettingsView(),
    );
  }
}
