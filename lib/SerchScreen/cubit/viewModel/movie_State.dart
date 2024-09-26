import '../Respone/SearchRespone.dart';

abstract class searchStates {}

class SearchStatesInitial extends searchStates {}

class SearchStatesLoading extends searchStates {}

class SearchStatesSuccess extends searchStates {
  MovieResponse SearchResponse;

  SearchStatesSuccess({required this.SearchResponse});
}

class SearchStatesError extends searchStates {
  String errorMsg;

  SearchStatesError({required this.errorMsg});
}
