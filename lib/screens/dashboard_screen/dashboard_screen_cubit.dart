import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobis/models/financial_institution.dart';

import '../../remote/financial_institution_repository.dart';

part 'dashboard_screen_state.dart';

class DashboardScreenCubit extends Cubit<DashboardScreenState> {
  DashboardScreenCubit(this.financialInstitutionRepository)
      : super(DashboardScreenInitial());

  final FinancialInstitutionRepository financialInstitutionRepository;

  void getFinancialInstitutions() {
    emit(DashboardScreenLoading());
    financialInstitutionRepository
        .getSupportedFinancialInstitutions()
        .then((data) => emit(DashboardScreenSuccess(data)))
        .catchError((error, stackTrace) {
      debugPrint(error.toString());
      debugPrintStack(stackTrace: stackTrace);
      emit(DashboardScreenError());
    });
  }
}
