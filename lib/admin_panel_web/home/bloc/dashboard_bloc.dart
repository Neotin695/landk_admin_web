import 'dart:async';
import 'package:admin_panel_web/admin_panel_web/home/repository/dashboard_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardStatus> {
  DashboardBloc({required this.dashboardRepository})
      : super(DashboardStatus.initial) {
    on<AnalyseData>(_analyseData);
  }

  final DashboardRepository dashboardRepository;
  Analysis analysis = Analysis.empty();
  FutureOr<void> _analyseData(AnalyseData event, emit) async {
    emit(DashboardStatus.loading);
    analysis = await dashboardRepository.analyseData();

    if (analysis != Analysis.empty()) {
      emit(DashboardStatus.success);
    }
  }
}
