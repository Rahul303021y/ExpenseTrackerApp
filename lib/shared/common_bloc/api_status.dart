/*
 * _______________________________
 * Created By: Rahul Kumar
 * Created At: 18-08-2026 - 15:21
 * Product Name: Expenzo
 * ________________________________
 */

class ApiStatus {
  const ApiStatus();
}

class ApiInitialState extends ApiStatus {
  const ApiInitialState();
}

class ApiLoadingState extends ApiStatus {
  ApiLoadingState({this.responseList});
  final List<dynamic>? responseList;

  List<Object?> get props => [];
}

class ApiSuccessState extends ApiStatus {
  ApiSuccessState({this.responseList, this.response});
  final List<dynamic>? responseList;
  final dynamic response;

  ApiSuccessState copyWith({dynamic response, List<dynamic>? responseList}) {
    return ApiSuccessState(
      responseList: responseList ?? this.responseList,
      response: response ?? this.response,
    );
  }

  List<Object?> get props => [responseList, response];

  @override
  String toString() {
    return 'ApiSuccessState{responseList: $responseList, response: $response}';
  }
}

class ApiFailureState extends ApiStatus {
  ApiFailureState({this.exception});
  final dynamic exception;
}