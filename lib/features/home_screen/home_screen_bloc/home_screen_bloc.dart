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
      final response = await repository.getExpenses();

      if (response.status) {
        emit(HomeScreenLoaded(response.data.expenseList));
      } else {
        emit(HomeScreenError(response.developerMessage));
      }
    } catch (e) {
      emit(HomeScreenError(e.toString()));
    }
  }
}