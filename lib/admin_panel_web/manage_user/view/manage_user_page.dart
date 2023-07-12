import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/manage_user_bloc.dart';
import '../repository/manage_user_repository.dart';
import 'manage_user_view.dart';

class ManageUserPage extends StatelessWidget {
  static Page page() => MaterialPage(
          child: ManageUserPage(
        manageUserRepository: ManageUserRepository(),
      ));
  const ManageUserPage({super.key, required this.manageUserRepository});
  final ManageUserRepository manageUserRepository;
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: (context) => manageUserRepository,
      child: BlocProvider(
        create: (context) =>
            ManageUserBloc(manageUserRepository: manageUserRepository),
        child: const ManageUserView(),
      ),
    );
  }
}
