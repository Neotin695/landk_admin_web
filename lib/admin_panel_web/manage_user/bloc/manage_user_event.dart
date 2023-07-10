// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'manage_user_bloc.dart';

abstract class ManageUserEvent extends Equatable {
  const ManageUserEvent();

  @override
  List<Object> get props => [];
}

class FetchCustomer extends ManageUserEvent {
  final String uid;
  const FetchCustomer({
    required this.uid,
  });
}

class _FetchAllCustomers extends ManageUserEvent {
  final List<Customer> customers;
  const _FetchAllCustomers({
    required this.customers,
  });
}

class DeleteCustomer extends ManageUserEvent {
  final String uid;
  const DeleteCustomer({
    required this.uid,
  });
}

class ToggleActiveCustomer extends ManageUserEvent {
  final String uid;
  final bool state;
  const ToggleActiveCustomer({
    required this.state,
    required this.uid,
  });
}

class SearchCustomer extends ManageUserEvent {
  final String query;
  const SearchCustomer({
    required this.query,
  });
}
