part of 'manage_user_bloc.dart';

enum ManageUserStatus {
  success,
  failure,
  loading,
  initial,
}

// ignore: must_be_immutable
class ManageUserState extends Equatable {
  ManageUserState({required this.state});

  ManageUserStatus state;

  @override
  List<Object?> get props => [state];
  ManageUserState copyWith({ManageUserStatus? state}) {
    return ManageUserState(state: state ?? this.state);
  }
}
