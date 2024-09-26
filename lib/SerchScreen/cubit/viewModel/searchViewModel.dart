import 'package:flutter_bloc/flutter_bloc.dart';

import '../ApiSearchManger.dart';
import '../Respone/SearchRespone.dart';
import 'movie_State.dart';

class Searchtabviewmodel extends Cubit<Searchstates> {
  Searchtabviewmodel() : super(searchInitState());
  List<Search> searchlist = [];
  void searchMovie({required String query}) async {
    try {
      emit(searchLoadingState());
      var response = await ApiSearchManager.searchMovies(query);
      searchlist = response.results ?? [];
      emit(searchSuccessState(response: response));
    } catch (e) {
      emit(searchErrorState(errorMessage: e.toString()));
      throw e; // Consider logging or handling the error appropriately
    }
  }
}
