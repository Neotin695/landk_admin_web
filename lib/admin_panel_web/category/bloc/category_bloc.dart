import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/services/image_picker/image_picker_mixin.dart';
import '../repository/category_repository.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState>
    with PickMediaMixin {
  CategoryBloc({required this.categoryRepository})
      : super(const CategoryState(status: CategoryStatus.initial)) {
    on<_FethcAllCategory>(_fetchAllCategorys);
    on<DeleteCategory>(_deleteCategory);
    on<PickImage>(_pickImage);
    on<InsertCategory>(_insertCategory);
    _streamSubscription = categoryRepository.fetchAllCategory().listen((event) {
      add(_FethcAllCategory(categories: event));
    });
  }

  final CategoryRepository categoryRepository;
  late final StreamSubscription<List<Category>> _streamSubscription;
  List<Category> categories = [];
  final TextEditingController name = TextEditingController();

  Uint8List? imageUrl;

  FutureOr<void> _pickImage(event, emit) async {
    emit(const CategoryState(status: CategoryStatus.pickLoading));
    final result = await pickSingleImage(ImageSource.gallery);
    if (result != null) {
      imageUrl = result;
      emit(const CategoryState(status: CategoryStatus.pickSuccess));
    }
  }

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
      if (imageUrl != null) {
        await categoryRepository
            .insertCategory(imageUrl!, name.text)
            .then((value) {
          imageUrl = null;

          name.clear();
          emit(const CategoryState(status: CategoryStatus.pickLoading));
          emit(const CategoryState(status: CategoryStatus.success));
        });
      } else {
        emit(const CategoryState(status: CategoryStatus.failure));
      }
    } else {
      emit(const CategoryState(status: CategoryStatus.failure));
    }
      emit(const CategoryState(status: CategoryStatus.loadedData));
  }

  FutureOr<void> _fetchAllCategorys(_FethcAllCategory event, emit) {
    emit(const CategoryState(status: CategoryStatus.loadingData));
    categories = event.categories;
    if (categories.isNotEmpty) {
      emit(const CategoryState(status: CategoryStatus.loadedData));
    }else{
       emit(const CategoryState(status: CategoryStatus.initial));
    }
  }
}
