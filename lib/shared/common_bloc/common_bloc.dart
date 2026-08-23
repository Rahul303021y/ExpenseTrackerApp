/*
 * _______________________________
 * Created By: Rahul Kumar
 * Created At: 18-08-2026 - 15:20
 * Product Name: Expenzo
 * ________________________________
 */

import 'package:expensetrackerapp/shared/common_bloc/common_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'api_status.dart';
import 'common_event.dart';

class CommonBloc extends Bloc<CommonEvent, CommonState> {
  CommonBloc() : super(const CommonState()) {
    on<CallApiEvent>(_onCallApi);
    on<ResetApiEvent>((event, emit) => emit(const CommonState()));
  }

  Future<void> _onCallApi(CallApiEvent event, Emitter<CommonState> emit) async {
    emit(state.copyWith(apiStatus: ApiLoadingState()));
    try {
      final response = await event.apiCall();
      emit(
        state.copyWith(
          apiStatus: event.isList
              ? ApiSuccessState(responseList: response as List)
              : ApiSuccessState(response: response),
        ),
      );
    } catch (e) {
      emit(state.copyWith(apiStatus: ApiFailureState(exception: e)));
    }
  }
}