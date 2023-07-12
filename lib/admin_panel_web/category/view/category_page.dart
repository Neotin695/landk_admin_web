import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/category_bloc.dart';
import '../repository/category_repository.dart';
import 'category_view.dart';

class CategoryPage extends StatelessWidget {
  static Page page() => const MaterialPage(child: CategoryPage());
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => CategoryRepository(),
      child: BlocProvider(
        create: (context) => CategoryBloc(
            categoryRepository:
                context.select((CategoryRepository value) => value)),
        child: const CategoryView(),
      ),
    );
  }
}
