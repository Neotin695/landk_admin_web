import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/banner_bloc.dart';
import '../repository/src/banner_repository.dart';
import 'banner_view.dart';

class BannerPage extends StatelessWidget {
  static Page page() => MaterialPage(
          child: BannerPage(
        bannerRepository: BannerRepository(),
      ));
  const BannerPage({super.key, required this.bannerRepository});

  final BannerRepository bannerRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: bannerRepository,
      child: BlocProvider(
        create: (context) => BannerBloc(bannerRepository: bannerRepository),
        child: const BannerView(),
      ),
    );
  }
}
