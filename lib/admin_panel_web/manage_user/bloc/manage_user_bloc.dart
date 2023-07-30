import 'dart:async';
import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';

import '../repository/manage_user_repository.dart';
part 'manage_user_event.dart';
part 'manage_user_state.dart';

class ManageUserBloc extends Bloc<ManageUserEvent, ManageUserState> {
  ManageUserBloc({required this.manageUserRepository})
      : super(ManageUserState(state: ManageUserStatus.initial)) {
    on<_FetchAllCustomers>(_fetchAllCustomers);

    on<FetchCustomer>(_fetchCustomer);
    on<ToggleActiveCustomer>(_toggleActiveCustomer);
    on<DeleteCustomer>(_deleteCustomer);

    manageUserRepository.fetchAllCustomers().fold((l) => print(l), (r) {
      _streamSubscription = r.listen((event) {
        add(_FetchAllCustomers(customers: event));
      });
    });
  }

  final ManageUserRepository manageUserRepository;
  late StreamSubscription<List<Customer>> _streamSubscription;
  List<Customer> customers = [];
  Customer customer = Customer.empty();

  @override
  Future<void> close() {
    _streamSubscription.cancel();
    return super.close();
  }

  FutureOr<void> _toggleActiveCustomer(ToggleActiveCustomer event, emit) async {
    emit(ManageUserState(state: ManageUserStatus.loading));

    await manageUserRepository
        .toggleActiveCustomer(event.uid, event.state)
        .then(
            (value) => emit(ManageUserState(state: ManageUserStatus.success)));
  }

  FutureOr<void> _deleteCustomer(DeleteCustomer event, emit) async {
    emit(ManageUserState(state: ManageUserStatus.loading));
    await manageUserRepository.deleteCustomer(event.uid).then(
        (value) => emit(ManageUserState(state: ManageUserStatus.success)));
  }

  FutureOr<void> _fetchCustomer(FetchCustomer event, emit) async {
    emit(ManageUserState(state: ManageUserStatus.loading));
    customer = await manageUserRepository.fetchCustomer(event.uid);
    emit(ManageUserState(state: ManageUserStatus.success));
  }

  // ignore: library_private_types_in_public_api
  FutureOr<void> _fetchAllCustomers(_FetchAllCustomers event, emit) async {
    emit(ManageUserState(state: ManageUserStatus.loading));

    customers = event.customers;
    if (customers.isNotEmpty) {
      emit(ManageUserState(state: ManageUserStatus.success));
    }
  }
}
