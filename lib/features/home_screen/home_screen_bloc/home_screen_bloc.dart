import 'package:expensetrackerapp/features/home_screen/home_screen_bloc/home_screen_event.dart';
import 'package:expensetrackerapp/features/home_screen/home_screen_data/home_screen_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_screen_state.dart';

class HomeBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  final HomeScreenRepo repository;

  HomeBloc({
    required this.repository,
  }) : super(HomeScreenInitial()) {
    on<HomeStarted>(_onHomeStarted);
  }

  Future<void> _onHomeStarted(
      HomeStarted event,
      Emitter<HomeScreenState> emit,
      ) async {
    emit(HomeScreenLoading());

    try {
      final expenseFuture = repository.getExpenses();
      final summaryFuture = repository.fetchAccountSummary();

      final expenseResponse = await expenseFuture;
      final summaryResponse = await summaryFuture;

      if (expenseResponse.status && summaryResponse.status) {
        emit(HomeScreenLoaded(
          expenseResponse.data.expenseList,
          summaryResponse.data,
        ));
      } else {
        emit(HomeScreenError(
          !expenseResponse.status
              ? expenseResponse.developerMessage
              : summaryResponse.developerMessage,
        ));
      }
    } catch (e) {
      emit(HomeScreenError(e.toString()));
    }
  }
}