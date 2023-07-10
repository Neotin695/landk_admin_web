import 'package:flutter/material.dart';

import 'category_view.dart';

class CategoryPage extends StatelessWidget {
  static Page page() => const MaterialPage(child: CategoryPage());
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CategoryView(),
    );
  }
}
