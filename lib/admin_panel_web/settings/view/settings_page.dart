import 'package:admin_panel_web/admin_panel_web/app/app.dart';
import 'package:admin_panel_web/admin_panel_web/settings/view/settings_view.dart';
import 'package:admin_panel_web/core/services/common.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  static Page page() => const MaterialPage(child: SettingsPage());
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body:  SettingsView()
    );
  }
}
