import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'admin_panel_web/app/app.dart';
import 'admin_panel_web/auth/repository/authentication_repository.dart';
import 'core/services/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = AppBlocObserver();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final authenticationRepository = AuthenticationRepository();

  await authenticationRepository.user.first;
  runApp(App(authenticationRepository: authenticationRepository));
}
