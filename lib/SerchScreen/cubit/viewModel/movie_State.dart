import '../Respone/SearchRespone.dart';

abstract class Searchstates {}

class searchInitState extends Searchstates {}

class searchLoadingState extends Searchstates {}

class searchSuccessState extends Searchstates {
  MovieResponse response;
  searchSuccessState({required this.response});
}

class searchErrorState extends Searchstates {
  final String errorMessage;
  searchErrorState({required this.errorMessage});
}
