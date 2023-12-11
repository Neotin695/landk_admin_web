import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/tools/tools_widget.dart';
import '../bloc/banner_bloc.dart';

class BannerList extends StatelessWidget {
  const BannerList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BannerBloc, BannerState>(
      buildWhen: (previous, next) => previous != next,
      builder: (context, state) {
        if (state.status == BannerStatus.loadedData) {
          return Expanded(
            child: GridView.count(
              crossAxisCount: 6,
              mainAxisSpacing: 2,
              crossAxisSpacing: 2,
              children: context.read<BannerBloc>().banners.map(
                (e) {
                  return Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10)),
                    ),
                    child: InkWell(
                      onTap: () {
                        context.read<BannerBloc>().add(DeleteBanner(uid: e.id));
                      },
                      child: CachedNetworkImage(
                        imageUrl: e.photoUrl,
                        placeholder: (context, url) => loadingWidget(),
                      ),
                    ),
                  );
                },
              ).toList(),
            ),
          );
        } else if (state.status == BannerStatus.loadingData) {
          return loadingWidget();
        }
        return emptyData(context);
      },
    );
  }
}
