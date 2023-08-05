import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/tools/tools_widget.dart';
import '../bloc/category_bloc.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        if (state.status == CategoryStatus.loadedData) {
          return Expanded(
            child: GridView.count(
              crossAxisCount: 6,
              mainAxisSpacing: 2,
              crossAxisSpacing: 2,
              children: context.read<CategoryBloc>().categories.map((e) {
                return Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10)),
                  ),
                  child: GestureDetector(
                    onTap: () => context
                        .read<CategoryBloc>()
                        .add(DeleteCategory(uid: e.id)),
                    child: CachedNetworkImage(
                      imageUrl: e.imageUrl,
                      placeholder: (context, url) => loadingWidget(),
                    ),
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
    );
  }
}