import 'package:admin_panel_web/admin_panel_web/app/app.dart';
import 'package:admin_panel_web/admin_panel_web/auth/repository/authentication_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../core/services/common.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          DropdownButton(
            items: const [
              DropdownMenuItem(value: 'ar', child: Text('العربية')),
              DropdownMenuItem(value: 'en', child: Text('English')),
            ],
            onChanged: (value) async {
              await Common.prefs
                  .setString('locale', value!)
                  .then((value) => AppView.restartApp(context));
            },
          )
        ],
      ),
    );
  }
}
