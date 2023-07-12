// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'banner_bloc.dart';

abstract class BannerEvent extends Equatable {
  const BannerEvent();

  @override
  List<Object> get props => [];
}

// ignore: unused_element
class _FethcAllBanners extends BannerEvent {
  final List<Banner> banners;
  const _FethcAllBanners({
    required this.banners,
  });
}

class DeleteBanner extends BannerEvent {
  final String uid;
  const DeleteBanner({
    required this.uid,
  });
}

class InsertBanner extends BannerEvent {}

class PickImage extends BannerEvent {}
