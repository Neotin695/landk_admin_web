// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'banner_bloc.dart';

enum BannerStatus { loading, success, failure, initial }

class BannerState extends Equatable {
  final BannerStatus status;
  const BannerState({
    required this.status,
  });

  @override
  List<Object?> get props => [status];
}
