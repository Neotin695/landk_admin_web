import 'dart:async';
import 'package:admin_panel_web/admin_panel_web/vendors/vendors_repository/src/models/model.dart';
import 'package:admin_panel_web/admin_panel_web/vendors/vendors_repository/src/vendors_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'vendors_event.dart';
part 'vendors_state.dart';

class VendorsBloc extends Bloc<VendorsEvent, VendorsState> {
  VendorsBloc(this.vendorsRepository) : super(VendorsState.initial) {
    on<_FetchAllVendors>(_fetchAllVendor);
    on<DeleteVendor>(_deleteVendor);
    on<RejectVendor>(_rejectVendor);
    on<AcceptVendor>(_acceptVendor);
    on<FetchOneVendor>(_fetchOneVendor);
    on<ToggleVendorState>(_toggleVendorState);
    _subscription = vendorsRepository.fetchVendors().listen((event) {
      add(_FetchAllVendors(vendors: event));
    });
    _subscription.onError((err) {
      print(err);
    });
  }

  FutureOr<void> _fetchOneVendor(FetchOneVendor event, emit) {
    emit(VendorsState.loading);
    vendor = event.vendor;
    if (vendor != Store.empty()) {
      emit(VendorsState.success);
    }
  }

  final VendorsRepository vendorsRepository;
  List<Store> vendors = [];
  Store vendor = Store.empty();
  late final StreamSubscription<List<Store>> _subscription;

  FutureOr<void> _toggleVendorState(ToggleVendorState event, emit) async {
    await vendorsRepository.toggleVendorState(event.id, event.state);
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }

  FutureOr<void> _rejectVendor(RejectVendor event, emit) async {
    await vendorsRepository.rejectVendor(event.id);
  }

  FutureOr<void> _acceptVendor(AcceptVendor event, emit) async {
    await vendorsRepository.acceptVendor(event.id);
  }

  FutureOr<void> _deleteVendor(DeleteVendor event, emit) async {
    await vendorsRepository.deleteVendor(event.id);
  }

  FutureOr<void> _fetchAllVendor(_FetchAllVendors event, emit) {
    emit(VendorsState.loading);
    vendors = event.vendors;
    if (vendors.isNotEmpty) {
      emit(VendorsState.success);
    }
  }
}
