import 'dart:async';

import 'package:admin_panel_web/core/services/image_picker/image_picker_mixin.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../repository/banner_repository.dart';

part 'banner_event.dart';
part 'banner_state.dart';

class BannerBloc extends Bloc<BannerEvent, BannerState> with PickMediaMixin {
  BannerBloc({required this.bannerRepository})
      : super(const BannerState(status: BannerStatus.initial)) {
    on<_FethcAllBanners>(_fetchAllBanners);

    on<PickImage>(_pickeImage);
    on<DeleteBanner>(_deleteBanner);
    on<InsertBanner>(_insertBanner);
    bannerRepository.fetchAllBanners().fold((l) {
      print(l);
    }, (r) {
      _streamSubscription = r.listen((event) {
        banners = event;
        add(_FethcAllBanners(banners: banners));
      });
    });
  }

  FutureOr<void> _pickeImage(PickImage event, emit) async {
    emit(const BannerState(status: BannerStatus.pickLoading));
    final result = await pickSingleImage(ImageSource.gallery);
    if (result != null) {
      imageUrl = result;
      emit(const BannerState(status: BannerStatus.pickSuccess));
    }
  }

  final BannerRepository bannerRepository;
  late final StreamSubscription<List<Banner>> _streamSubscription;
  List<Banner> banners = [];
  Uint8List? imageUrl;

  FutureOr<void> _deleteBanner(DeleteBanner event, emit) async {
    emit(const BannerState(status: BannerStatus.loadingData));
    await bannerRepository.deleteBanner(event.uid).then(
        (value) => emit(const BannerState(status: BannerStatus.loadedData)));
  }

  @override
  Future<void> close() {
    _streamSubscription.cancel();
    return super.close();
  }

  FutureOr<void> _insertBanner(InsertBanner event, emit) async {
    emit(const BannerState(status: BannerStatus.loading));
    if (imageUrl != null) {
      await bannerRepository.insertBanner(imageUrl!).then((value) {
        imageUrl = null;
        emit(const BannerState(status: BannerStatus.pickLoading));
        emit(const BannerState(status: BannerStatus.success));
      });
    }
    emit(const BannerState(status: BannerStatus.loadedData));
  }

  FutureOr<void> _fetchAllBanners(_FethcAllBanners event, emit) {
    emit(const BannerState(status: BannerStatus.loadingData));
    banners = event.banners;
    if (banners.isNotEmpty) {
      emit(const BannerState(status: BannerStatus.loadedData));
    } else {
      emit(const BannerState(status: BannerStatus.initial));
    }
  }
}
