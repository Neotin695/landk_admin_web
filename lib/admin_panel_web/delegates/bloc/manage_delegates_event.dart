// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'manage_delegates_bloc.dart';

abstract class ManageDelegatesEvent extends Equatable {
  const ManageDelegatesEvent();

  @override
  List<Object> get props => [];
}

class FetchDelegate extends ManageDelegatesEvent {
  final String uid;
  const FetchDelegate({
    required this.uid,
  });
}

class _FetchAllDelegates extends ManageDelegatesEvent {
  final List<Delegate> delegates;
  const _FetchAllDelegates({
    required this.delegates,
  });
}

class DeleteDelegate extends ManageDelegatesEvent {
  final String uid;
  const DeleteDelegate({
    required this.uid,
  });
}

class ToggleActiveDelegate extends ManageDelegatesEvent {
  final String uid;
  final bool state;
  const ToggleActiveDelegate({
    required this.state,
    required this.uid,
  });
}

class AccepteDelegate extends ManageDelegatesEvent {
  final String uid;
  
  const AccepteDelegate({
  
    required this.uid,
  });
}

class RejectDelegate extends ManageDelegatesEvent {
  final String uid;
  
  const RejectDelegate({
  
    required this.uid,
  });
}

class SearchDelegate extends ManageDelegatesEvent {
  final String query;
  const SearchDelegate({
    required this.query,
  });
}
