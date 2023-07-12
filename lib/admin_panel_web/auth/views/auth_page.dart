import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/auth_cubit.dart';
import '../repository/authentication_repository.dart';
import 'auth_view.dart';

class AuthPage extends StatelessWidget {
  static Page<void> page() => const MaterialPage<void>(child: AuthPage());
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) =>
            AuthCubit(context.read<AuthenticationRepository>()),
        child: const AuthView(),
      ),
    );
  }
}
