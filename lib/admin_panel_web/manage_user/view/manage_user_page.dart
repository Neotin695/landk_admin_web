import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/manage_user_bloc.dart';
import '../repository/src/manage_user_repository.dart';

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
      value: manageUserRepository,
      child: BlocProvider(
        create: (context) =>
            ManageUserBloc(manageUserRepository: manageUserRepository),
        child: Container(),
      ),
    );
  }
}
