import 'package:admin_panel_web/core/theme/colors/landk_colors.dart';
import 'package:admin_panel_web/core/theme/fonts/landk_fonts.dart';
import 'package:admin_panel_web/core/tools/tools_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/language/lang.dart';
import 'package:sizer/sizer.dart';

import '../bloc/category_bloc.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        title: Text(
          AppLocalizations.of(context)!.categories,
          style: TextStyle(color: black),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Card(
            color: grey1,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.insertNewCategory,
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
                AppLocalizations.of(context)!.categories,
                style: h5,
              ),
            ),
          ),
          BlocBuilder<CategoryBloc, CategoryState>(
            builder: (context, state) {
              if (state.status == CategoryStatus.loadedData) {
                return Expanded(
                  child: GridView.count(
                    crossAxisCount: 4,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    children: context.read<CategoryBloc>().categories.map((e) {
                      return GestureDetector(
                        onDoubleTap: () => context
                            .read<CategoryBloc>()
                            .add(DeleteCategory(uid: e.id)),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CachedNetworkImage(
                              imageUrl: e.imageUrl,
                              placeholder: (context, url) => loadingWidget(),
                            ),
                            vSpace(1),
                            Text(
                              e.name,
                              style: h6!.copyWith(
                                fontSize: 5.sp,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                );
              } else if (state.status == CategoryStatus.loadingData) {
                return loadingWidget();
              } else {
                return empty();
              }
            },
          )
        ],
      ),
    );
  }
}

class _Actions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        hSpace(5),
        Expanded(
          child: Container(
            width: 15.w,
            height: 10.h,
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(),
            ),
            child: Center(
              child: TextField(
                controller: context.read<CategoryBloc>().name,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.typeCategoryName,
                    border: InputBorder.none),
              ),
            ),
          ),
        ),
        hSpace(5),
        Expanded(child: _UploadImage()),
        hSpace(5),
        Expanded(
          child: BlocBuilder<CategoryBloc, CategoryState>(
            builder: (context, state) {
              return ElevatedButton(
                onPressed: () {
                  context.read<CategoryBloc>().add(InsertCategory());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: organge,
                  padding: const EdgeInsets.all(40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: state.status == CategoryStatus.loading
                    ? loadingWidget()
                    : Text(
                        AppLocalizations.of(context)!.saveNewCategory,
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
                context.read<CategoryBloc>().add(PickImage());
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
            child: BlocBuilder<CategoryBloc, CategoryState>(
              builder: (context, state) {
                if (state.status == CategoryStatus.pickSuccess) {
                  return Container(
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10)),
                    ),
                    child: Image.memory(context.read<CategoryBloc>().imageUrl!),
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
          ),
        ],
      ),
    );
  }
}
