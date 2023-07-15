import 'dart:async';
import 'package:admin_panel_web/admin_panel_web/delegates/repository/src/model/model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../repository/src/manage_delegates_repository.dart';

part 'manage_delegates_event.dart';
part 'manage_delegates_state.dart';

class ManageDelegatesBloc
    extends Bloc<ManageDelegatesEvent, ManageDelegatesStatus> {
  ManageDelegatesBloc({required this.manageDelegatesRepository})
      : super(ManageDelegatesStatus.initial) {
    on<_FetchAllDelegates>(_fetchAllDelegates);

    on<FetchDelegate>(_fetchDelegate);
    on<ToggleActiveDelegate>(_toggleActiveDelegate);
    on<AccepteDelegate>(_accepteDelegate);
    on<DeleteDelegate>(_deleteDelegate);

    manageDelegatesRepository.fetchAllDelegates().fold((l) => print(l), (r) {
      _streamSubscription = r.listen((event) {
        add(_FetchAllDelegates(delegates: event));
      });
    });
  }

  final ManageDelegatesRepository manageDelegatesRepository;
  late final StreamSubscription<List<Delegate>> _streamSubscription;
  List<Delegate> delegates = [];
  Delegate delegate = Delegate.empty();

  @override
  Future<void> close() {
    _streamSubscription.cancel();
    return super.close();
  }

  FutureOr<void> _toggleActiveDelegate(ToggleActiveDelegate event, emit) async {
    emit(ManageDelegatesStatus.loading);

    await manageDelegatesRepository
        .toggleActiveDelegate(event.uid, event.state)
        .then((value) =>
            emit(ManageDelegatesStatus.success));
  }

  FutureOr<void> _accepteDelegate(AccepteDelegate event, emit) async {
    emit( ManageDelegatesStatus.loading);

    await manageDelegatesRepository.acceptDelegate(event.uid, event.state).then(
        (value) =>
            emit(ManageDelegatesStatus.success));
  }

  FutureOr<void> _deleteDelegate(DeleteDelegate event, emit) async {
    emit(ManageDelegatesStatus.loading);
    await manageDelegatesRepository.deleteDelegate(event.uid).then((value) =>
        emit(ManageDelegatesStatus.success));
  }

  FutureOr<void> _fetchDelegate(FetchDelegate event, emit) async {
    emit(ManageDelegatesStatus.loading);
    delegate = await manageDelegatesRepository.fetchDelegate(event.uid).then(
        (value) =>
            emit(ManageDelegatesStatus.success));
  }

  // ignore: library_private_types_in_public_api
  FutureOr<void> _fetchAllDelegates(_FetchAllDelegates event, emit) async {
    emit(ManageDelegatesStatus.loading);

    delegates = event.delegates;
    if (delegates.isNotEmpty) {
      emit(ManageDelegatesStatus.success);
    }
  }
}
