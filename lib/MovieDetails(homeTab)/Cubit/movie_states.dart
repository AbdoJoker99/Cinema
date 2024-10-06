import 'package:cinema/HomeTab/Data/Response/SimilarDetailsResponse.dart';

import '../../HomeTab/Data/Response/DetailsResponse.dart';

abstract class MovieDetailsStates {}

class MovieDetailsInitialState extends MovieDetailsStates {}

class MovieDetailsLoadingState extends MovieDetailsStates {}

class MovieDetailsSuccessState extends MovieDetailsStates {
  DetailsResponse details;

  MovieDetailsSuccessState({required this.details});
}

class MovieDetailsErrorState extends MovieDetailsStates {
  String errorMsg;
  MovieDetailsErrorState(this.errorMsg);
}

class MovieSimilarDetailsLoadingState extends MovieDetailsStates {}

class MovieSimilarDetailsSuccessState extends MovieDetailsStates {
  SimilarDetailsResponse similarDetails;

  MovieSimilarDetailsSuccessState({required this.similarDetails});
}

class MovieSimilarDetailsErrorState extends MovieDetailsStates {
  String errorMsg;
  MovieSimilarDetailsErrorState(this.errorMsg);
}
