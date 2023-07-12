import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/manage_user_bloc.dart';
import '../repository/manage_user_repository.dart';
import 'manage_user_view.dart';

class ManageUserPage extends StatelessWidget {
  static Page page() => const MaterialPage(child: ManageUserPage());
  const ManageUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: (context) => ManageUserRepository(),
      child: BlocProvider(
        create: (context) => ManageUserBloc(
            manageUserRepository:
                context.select((ManageUserRepository value) => value)),
        child: const ManageUserView(),
      ),
    );
  }
}
