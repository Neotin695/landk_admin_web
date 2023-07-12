// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

// ignore: unused_element
class _FethcAllCategory extends CategoryEvent {
  final List<Category> categories;
  const _FethcAllCategory({
    required this.categories,
  });
}

class DeleteCategory extends CategoryEvent {
  final String uid;
  const DeleteCategory({
    required this.uid,
  });
}

class InsertCategory extends CategoryEvent {}

class PickImage extends CategoryEvent {}
