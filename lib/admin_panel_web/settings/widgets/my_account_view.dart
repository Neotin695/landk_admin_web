import 'package:admin_panel_web/core/shared/outlined_text.dart';
import 'package:admin_panel_web/core/tools/tools_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../core/language/lang.dart';
import '../../../core/theme/colors/landk_colors.dart';
import '../../../core/theme/fonts/landk_fonts.dart';

class MyAccount extends StatelessWidget {
  const MyAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          hSpace(2),
          OutlinedText(
            text: '${FirebaseAuth.instance.currentUser!.email}',
            title: AppLocalizations.of(context)!.email,
          ),
          hSpace(2),
           OutlinedText(
            text: '**************',
            title: AppLocalizations.of(context)!.password,
          ),
          hSpace(3),
          _saveBtn(context)
        ],
      ),
    );
  }

  ElevatedButton _saveBtn(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {},
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
}
