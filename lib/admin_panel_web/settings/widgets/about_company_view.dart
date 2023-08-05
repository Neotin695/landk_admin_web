import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../core/language/lang.dart';
import '../../../core/shared/outlined_text.dart';
import '../../../core/tools/tools_widget.dart';

class AboutCompany extends StatelessWidget {
  const AboutCompany({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          hSpace(2),
          OutlinedText(
            text: AppLocalizations.of(context)!.landk,
            title: AppLocalizations.of(context)!.companyName,
          ),
          hSpace(2),
          OutlinedText(
            text: '${FirebaseAuth.instance.currentUser!.email}',
            title: AppLocalizations.of(context)!.email,
          ),
          hSpace(2),
          OutlinedText(
            text: '21321348594',
            title: AppLocalizations.of(context)!.phoneNum,
          ),
        ],
      ),
    );
  }
}
