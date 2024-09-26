import 'package:cinema/SerchScreen/Widgets/searchBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../HomeTab/widgets/movieCard.dart';
import '../cubit/viewModel/movie_State.dart';
import '../cubit/viewModel/searchViewModel.dart';
import 'noMoviesFound.dart';

class Searchsceentab extends StatefulWidget {
  static const String routeName = 'search';
  @override
  SearchsceentabState createState() => SearchsceentabState();
}

class SearchsceentabState extends State<Searchsceentab> {
  final Searchtabviewmodel _viewModel = Searchtabviewmodel();

  void onSearch(String text) {
    _viewModel.searchMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 30.0, vertical: 50.0),
            child: Searchbar(
              onSearch: onSearch,
            ),
          ),
          Expanded(
            child: BlocBuilder<Searchtabviewmodel, searchStates>(
              bloc: _viewModel..searchMovies(),
              builder: (context, state) {
                if (state is SearchStatesLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is SearchStatesSuccess) {
                  return ListView.builder(
                    itemCount: state.SearchResponse.results?.length,
                    itemBuilder: (context, index) {
                      final movie = state.SearchResponse.results?[index];
                      return MovieCard(moviecard: null);
                    },
                  );
                } else if (state is SearchStatesError) {
                  return Center(child: Text(state.errorMsg));
                } else if (state is SearchStatesInitial) {
                  return Center(child: NoMoviesFound());
                } else {
                  return Center(child: Text('Unknown state'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
