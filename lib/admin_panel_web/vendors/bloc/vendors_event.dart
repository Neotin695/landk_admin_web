// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'vendors_bloc.dart';

abstract class VendorsEvent extends Equatable {
  const VendorsEvent();

  @override
  List<Object> get props => [];
}

class _FetchAllVendors extends VendorsEvent {
  final List<Store> vendors;
  const _FetchAllVendors({
    required this.vendors,
  });
}

class FetchOneVendor extends VendorsEvent {
  final Store vendor;
  const FetchOneVendor({
    required this.vendor,
  });
  
}

class DeleteVendor extends VendorsEvent {
  final String id;
  const DeleteVendor({
    required this.id,
  });
}

class RejectVendor extends VendorsEvent {
  final String id;
  const RejectVendor({
    required this.id,
  });
}

class AcceptVendor extends VendorsEvent {
  final String id;
  const AcceptVendor({
    required this.id,
  });
}

class ToggleVendorState extends VendorsEvent {
  final String id;
  final bool state;
  const ToggleVendorState({
    required this.id,
    required this.state,
  });
}
