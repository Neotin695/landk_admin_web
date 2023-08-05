// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import 'package:admin_panel_web/core/theme/colors/landk_colors.dart';
import 'package:admin_panel_web/core/theme/fonts/landk_fonts.dart';
import 'package:admin_panel_web/core/tools/tools_widget.dart';

import '../../../core/language/lang.dart';
import '../../../core/shared/landk_tab.dart';
import '../bloc/category_bloc.dart';
import '../widgets/category_list.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({super.key});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView>
    with TickerProviderStateMixin {
  late final TabController _controller;

  @override
  void initState() {
    _controller = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, AppLocalizations.of(context)!.categories),
      body: Column(
        children: [
          vSpace(1),
          Align(
            alignment: autoAlignTop(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                AppLocalizations.of(context)!.insertNewCategory,
                style: h5,
              ),
            ),
          ),
          vSpace(2),
          Card(
            color: white,
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  landkTab(),
                  _Actions(
                    controller: _controller,
                  ),
                ],
              ),
            ),
          ),
          const _Title(),
          const CategoryList()
        ],
      ),
    );
  }

  Widget landkTab() {
    return LandkTab(
      controller: _controller,
      tabs: const [
        Tab(
          text: 'English',
        ),
        Tab(
          text: 'Arabic - العربية (AR)',
        ),
      ],
    );
  }
}

class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: autoAlignTop(),
            child: Text(
              '${AppLocalizations.of(context)!.categories} (${context.read<CategoryBloc>().categories.length})',
              style: h5,
            ),
          ),
        );
      },
    );
  }
}

class _Actions extends StatelessWidget {
  final TabController controller;
  const _Actions({
    Key? key,
    required this.controller,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        hSpace(5),
        SizedBox(
          width: 20.w,
          height: 10.h,
          child: TabBarView(
            controller: controller,
            children: [
              _inputCategory(context, context.read<CategoryBloc>().nameEn),
              _inputCategory(context, context.read<CategoryBloc>().nameAr),
            ],
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

  Widget _inputCategory(BuildContext context, TextEditingController cn) {
    return Container(
      width: 15.w,
      height: 10.h,
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(),
      ),
      child: Center(
        child: TextField(
          controller: cn,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.typeCategoryName,
              border: InputBorder.none),
        ),
      ),
    );
  }
}

class _UploadImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(width: 1)),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                context.read<CategoryBloc>().add(PickImage());
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                backgroundColor: organge,
                padding:
                    const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
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
                    child: context.read<CategoryBloc>().imageUrl == null
                        ? const SizedBox()
                        : Image.memory(context.read<CategoryBloc>().imageUrl!),
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
