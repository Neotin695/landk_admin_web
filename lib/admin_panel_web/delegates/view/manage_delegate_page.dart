import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/manage_delegates_bloc.dart';
import '../repository/manage_user_repository.dart';
import 'manage_delegate_view.dart';

class DelegatesPage extends StatelessWidget {
  static Page page() => MaterialPage(
          child: DelegatesPage(
        manageDelegatesRepository: ManageDelegatesRepository(),
      ));
  const DelegatesPage({super.key, required this.manageDelegatesRepository});
  final ManageDelegatesRepository manageDelegatesRepository;
  
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value:  manageDelegatesRepository,
      child: BlocProvider(
        create: (context) => ManageDelegatesBloc(
            manageDelegatesRepository: manageDelegatesRepository),
        child: const ManageDelegatesView(),
      ),
    );
  }
}
 