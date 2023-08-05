import 'package:admin_panel_web/admin_panel_web/vendors/vendors_repository/src/vendors_repository.dart';
import 'package:admin_panel_web/admin_panel_web/vendors/view/vendor_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/vendors_bloc.dart';

class VendorPage extends StatelessWidget {
  static Page page() =>
      MaterialPage(child: VendorPage(vendorsRepository: VendorsRepository()));
  const VendorPage({super.key, required this.vendorsRepository});

  final VendorsRepository vendorsRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: vendorsRepository,
      child: BlocProvider(
        create: (context) => VendorsBloc(vendorsRepository),
        child: const VendorView(),
      ),
    );
  }
}
