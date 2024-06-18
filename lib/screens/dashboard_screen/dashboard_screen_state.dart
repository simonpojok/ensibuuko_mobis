part of 'dashboard_screen_cubit.dart';

sealed class DashboardScreenState extends Equatable {
  const DashboardScreenState();
}

final class DashboardScreenInitial extends DashboardScreenState {
  @override
  List<Object> get props => [];
}

final class DashboardScreenLoading extends DashboardScreenState {
  @override
  List<Object> get props => [];
}

final class DashboardScreenSuccess extends DashboardScreenState {
  final List<FinancialInstitution> financialInstitutions;

  const DashboardScreenSuccess(this.financialInstitutions);

  @override
  List<Object> get props => [];
}

final class DashboardScreenError extends DashboardScreenState {
  @override
  List<Object> get props => [];
}
