import 'package:admin_panel_web/core/services/common.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'admin_panel_web/app/app.dart';
import 'admin_panel_web/auth/repository/authentication_repository.dart';

import 'core/services/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = AppBlocObserver();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Common.prefs = await SharedPreferences.getInstance();
  
  Common.prefs.getString('locale') == null
      ? await Common.prefs.setString('locale', 'en')
      : null;

      
  final authenticationRepository = AuthenticationRepository();

  await authenticationRepository.user.first;
  runApp(App(authenticationRepository: authenticationRepository));
}
