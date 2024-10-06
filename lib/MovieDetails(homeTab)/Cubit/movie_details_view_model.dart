import 'package:cinema/HomeTab/Data/apiManger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'movie_states.dart';

class MovieDetailsViewModel extends Cubit<MovieDetailsStates> {
  MovieDetailsViewModel() : super(MovieDetailsInitialState());

  // Variables to hold movie details and similar movie details
  dynamic movieDetails;
  dynamic similarDetails;

  Future<void> getAllDetails(int movieId) async {
    emit(MovieDetailsLoadingState());
    try {
      movieDetails = await ApiManager.getAllDetails(movieId);
      emit(MovieDetailsSuccessState(details: movieDetails));
    } catch (e) {
      emit(MovieDetailsErrorState("An error occurred: $e"));
    }
  }

  Future<void> getAllSimilarDetails(int movieId) async {
    emit(MovieSimilarDetailsLoadingState());
    try {
      similarDetails = await ApiManager.getAllSimilarDetails(movieId);
      emit(MovieSimilarDetailsSuccessState(similarDetails: similarDetails));
    } catch (e) {
      emit(MovieSimilarDetailsErrorState("An error occurred: $e"));
    }
  }
}
