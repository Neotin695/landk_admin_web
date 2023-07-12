// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'category_bloc.dart';

enum CategoryStatus {
  loading,
  success,
  failure,
  initial,
  pickLoading,
  pickSuccess,
  loadingData,
  loadedData,
}

class CategoryState extends Equatable {
  final CategoryStatus status;
  const CategoryState({
    required this.status,
  });

  @override
  List<Object?> get props => [status];
}
