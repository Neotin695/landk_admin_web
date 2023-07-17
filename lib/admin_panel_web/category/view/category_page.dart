import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/category_bloc.dart';
import '../repository/category_repository.dart';
import 'category_view.dart';

class CategoryPage extends StatelessWidget {
  static Page page() => MaterialPage(
          child: CategoryPage(
        categoryRepository: CategoryRepository(),
      ));
  const CategoryPage({super.key, required this.categoryRepository});

  final CategoryRepository categoryRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: categoryRepository,
      child: BlocProvider(
        create: (context) =>
            CategoryBloc(categoryRepository: categoryRepository),
        child: const CategoryView(),
      ),
    );
  }
}
