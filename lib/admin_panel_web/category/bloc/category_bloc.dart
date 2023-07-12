import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../repository/category_repository.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc({required this.categoryRepository})
      : super(const CategoryState(status: CategoryStatus.initial)) {
    on<_FethcAllCategory>(_fetchAllCategorys);
    on<DeleteCategory>(_deleteCategory);
    on<InsertCategory>(_insertCategory);
    _streamSubscription = categoryRepository.fetchAllCategory().listen((event) {
      add(_FethcAllCategory(categories: event));
    });
  }
  final CategoryRepository categoryRepository;
  late final StreamSubscription<List<Category>> _streamSubscription;
  List<Category> categorys = [];
  final TextEditingController name = TextEditingController();

  FutureOr<void> _deleteCategory(DeleteCategory event, emit) async {
    emit(const CategoryState(status: CategoryStatus.loading));
    await categoryRepository.deleteCategory(event.uid).then(
        (value) => emit(const CategoryState(status: CategoryStatus.success)));
  }

  @override
  Future<void> close() {
    _streamSubscription.cancel();
    return super.close();
  }

  FutureOr<void> _insertCategory(InsertCategory event, emit) async {
    emit(const CategoryState(status: CategoryStatus.loading));
    if (name.text.isNotEmpty) {
      await categoryRepository.insertCategory(event.imageUrl, name.text).then(
          (value) => emit(const CategoryState(status: CategoryStatus.success)));
    } else {
      emit(const CategoryState(status: CategoryStatus.failure));
    }
  }

  FutureOr<void> _fetchAllCategorys(_FethcAllCategory event, emit) {
    emit(const CategoryState(status: CategoryStatus.loading));
    categorys = event.categories;
    if (categorys.isNotEmpty) {
      emit(const CategoryState(status: CategoryStatus.success));
    }
  }
}
