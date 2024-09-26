import 'package:flutter_bloc/flutter_bloc.dart';

import '../ApiSearchManger.dart';
import '../Respone/SearchRespone.dart';
import 'movie_State.dart';

class Searchtabviewmodel extends Cubit<searchStates> {
  Searchtabviewmodel() : super(SearchStatesInitial());
  List<moviess>? searchlist;

  void searchMovies() async {
    try {
      emit(SearchStatesLoading());
      var response =
          await ApiSearchManager.searchMovies(ApiSearchManager.baseUrl);
      if (response.status_message == "fail") {
        emit(SearchStatesError(errorMsg: response.message!));
      } else {
        searchlist = response.results ?? [];
        emit(SearchStatesSuccess(SearchResponse: response));
      }
    } catch (e) {
      emit(SearchStatesError(errorMsg: e.toString()));
    }
  }
}
