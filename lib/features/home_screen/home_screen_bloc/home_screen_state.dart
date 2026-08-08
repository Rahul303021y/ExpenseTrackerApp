import '../home_screen_model/expense_model.dart';

abstract class HomeScreenState {}

class HomeScreenInitial extends HomeScreenState {}

class HomeScreenLoading extends HomeScreenState {}

class HomeScreenLoaded extends HomeScreenState {
  final List<Expense> expenses;

  HomeScreenLoaded(this.expenses);
}

class HomeScreenError extends HomeScreenState {
  final String message;

  HomeScreenError(this.message);
}