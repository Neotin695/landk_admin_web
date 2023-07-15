import 'package:admin_panel_web/admin_panel_web/banner/bloc/banner_bloc.dart';
import 'package:admin_panel_web/core/services/image_picker/image_picker_mixin.dart';
import 'package:admin_panel_web/core/theme/colors/landk_colors.dart';
import 'package:admin_panel_web/core/theme/fonts/landk_fonts.dart';
import 'package:admin_panel_web/core/tools/tools_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/language/lang.dart';

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
      body: Column(
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
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.topRight,
              child: Text(
                AppLocalizations.of(context)!.banner,
                style: h5,
              ),
            ),
          ),
          BlocBuilder<BannerBloc, BannerState>(
            buildWhen: (previous, next) => previous != next,
            builder: (context, state) {
              if (state.status == BannerStatus.loadedData) {
                return Expanded(
                  child: GridView.count(
                    crossAxisCount: 4,
                    mainAxisSpacing: 2,
                    crossAxisSpacing: 2,
                    children: context.read<BannerBloc>().banners.map(
                      (e) {
                        return GestureDetector(
                          onTap: () {
                            CoolAlert.show(
                              context: context,
                              type: CoolAlertType.confirm,
                              onConfirmBtnTap: () {},
                            );
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CachedNetworkImage(
                                imageUrl: e.photoUrl,
                                placeholder: (context, url) => loadingWidget(),
                              ),
                            ],
                          ),
                        );
                      },
                    ).toList(),
                  ),
                );
              } else if (state.status == BannerStatus.loadingData) {
                return loadingWidget();
              }
              return empty();
            },
          )
        ],
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
        hSpace(5),
        Expanded(child: _UploadImage()),
        hSpace(5),
        Expanded(
          child: BlocBuilder<BannerBloc, BannerState>(
            builder: (context, state) {
              return ElevatedButton(
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
                child: state.status == BannerStatus.loading
                    ? loadingWidget()
                    : Text(
                        AppLocalizations.of(context)!.saveNewBanner,
                        style: btnFont!.copyWith(color: white),
                      ),
              );
            },
          ),
        ),
        hSpace(5),
      ],
    );
  }
}

class _UploadImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(),
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                context.read<BannerBloc>().add(PickImage());
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
              child: Text(
                AppLocalizations.of(context)!.uploadImage,
                style: btnFont!.copyWith(color: white),
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<BannerBloc, BannerState>(
              builder: (context, state) {
                if (state.status == BannerStatus.pickSuccess) {
                  return Container(
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10)),
                    ),
                    child: context.read<BannerBloc>().imageUrl == null
                        ? const SizedBox()
                        : Image.memory(context.read<BannerBloc>().imageUrl!),
                  );
                }
                return Container(
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10)),
                  ),
                  child: const SizedBox(),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
