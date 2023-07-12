import 'package:admin_panel_web/admin_panel_web/banner/bloc/banner_bloc.dart';
import 'package:admin_panel_web/core/services/image_picker/image_picker_mixin.dart';
import 'package:admin_panel_web/core/theme/colors/landk_colors.dart';
import 'package:admin_panel_web/core/theme/fonts/landk_fonts.dart';
import 'package:admin_panel_web/core/tools/tools_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BannerView extends StatefulWidget {
  const BannerView({super.key});

  @override
  State<BannerView> createState() => _BannerViewState();
}

class _BannerViewState extends State<BannerView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        title: Text(
          AppLocalizations.of(context)!.banner,
          style: TextStyle(color: black),
        ),
        centerTitle: true,
      ),
      body: BlocListener<BannerBloc, BannerState>(
        listener: (context, state) {},
        child: Column(
          children: [
            Card(
              color: grey1,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.insertNewBanner,
                      style: h4,
                    ),
                    vSpace(2),
                    _Actions(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _Actions extends StatelessWidget with PickMediaMixin {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const _UploadImage(),
        ElevatedButton(
          onPressed: () {
            context.read<BannerBloc>().add(InsertBanner());
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: organge,
            padding: const EdgeInsets.all(40),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(AppLocalizations.of(context)!.saveNewBanner),
        ),
      ],
    );
  }
}

class _UploadImage extends StatelessWidget {
  const _UploadImage();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), border: Border.all()),
      child: Row(
        children: [
          ElevatedButton(
            onPressed: () async {
              context.read<BannerBloc>().add(SelectImage());
            },
            style: ElevatedButton.styleFrom(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
              ),
              backgroundColor: organge,
              padding: const EdgeInsets.all(40),
            ),
            child: Text(AppLocalizations.of(context)!.uploadImage),
          ),
          BlocBuilder<BannerBloc, BannerState>(
            builder: (context1s, state) {
              if (state.status == BannerStatus.success) {
                return Container(
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10)),
                  ),
                  child: Text(
                    context.read<BannerBloc>().imageName,
                    style: h6!.copyWith(color: black),
                  ),
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ],
      ),
    );
  }
}
