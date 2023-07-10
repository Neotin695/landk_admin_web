import 'dart:async';
import 'package:banner_repository/banner_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'banner_event.dart';
part 'banner_state.dart';

class BannerBloc extends Bloc<BannerEvent, BannerState> {
  BannerBloc({required this.bannerRepository})
      : super(const BannerState(status: BannerStatus.initial)) {
    on<_FethcAllBanners>(_fetchAllBanners);
    on<DeleteBanner>(_deleteBanner);
    on<InsertBanner>(_insertBanner);
    _streamSubscription = bannerRepository.fetchAllBanners().listen((event) {
      add(_FethcAllBanners(banners: event));
    });
  }
  final BannerRepository bannerRepository;
  late final StreamSubscription<List<Banner>> _streamSubscription;
  List<Banner> banners = [];

  FutureOr<void> _deleteBanner(DeleteBanner event, emit) async {
    emit(const BannerState(status: BannerStatus.loading));
    await bannerRepository
        .deleteBanner(event.uid)
        .then((value) => emit(const BannerState(status: BannerStatus.success)));
  }

  @override
  Future<void> close() {
    _streamSubscription.cancel();
    return super.close();
  }

  FutureOr<void> _insertBanner(InsertBanner event, emit) async {
    emit(const BannerState(status: BannerStatus.loading));
    await bannerRepository
        .insertBanner(event.imageUrl)
        .then((value) => emit(const BannerState(status: BannerStatus.success)));
  }

  FutureOr<void> _fetchAllBanners(_FethcAllBanners event, emit) {
    emit(const BannerState(status: BannerStatus.loading));
    banners = event.banners;
    if (banners.isNotEmpty) {
      emit(const BannerState(status: BannerStatus.success));
    }
  }
}
