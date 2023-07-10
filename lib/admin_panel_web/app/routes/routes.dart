import 'package:admin_panel_web/admin_panel_web/app/bloc/app_bloc.dart';
import 'package:admin_panel_web/admin_panel_web/auth/views/auth_page.dart';
import 'package:flutter/material.dart';

import '../../home/views/home_page.dart';

List<Page> onGenerateAuthPage(AppStatus appState, List<Page> pages) {
  switch (appState) {
    case AppStatus.unauthenticated:
      return [AuthPage.page()];
    case AppStatus.authenticated:
      return [HomePage.page()];
    default:
      return [AuthPage.page()];
  }
}
