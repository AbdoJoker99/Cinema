import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/viewModel/movie_State.dart';
import '../cubit/viewModel/searchViewModel.dart';

class SearchResults extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewmodel = BlocProvider.of<Searchtabviewmodel>(context);
    return BlocBuilder<Searchtabviewmodel, Searchstates>(
      builder: (context, state) {
        if (state is searchLoadingState) {
          return Center(
            child: CircularProgressIndicator(color: Colors.blue),
          );
        } else if (state is searchSuccessState) {
          return Expanded(
            child: ListView.builder(
              itemCount: viewmodel.searchlist.length,
              itemBuilder: (context, index) {
                final movie = viewmodel.searchlist[index];
                return InkWell(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    margin: EdgeInsets.only(bottom: 15.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[850],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 80,
                          height: 120,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              '${'https://image.tmdb.org/t/p/w500/'}${movie.posterPath}',
                              fit: BoxFit.cover,
                              filterQuality: FilterQuality.high,
                              errorBuilder: (context, error, stackTrace) =>
                                  Center(
                                      child: Icon(Icons.error,
                                          color: Colors.white)),
                            ),
                          ),
                        ),
                        SizedBox(width: 10.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                movie.title ?? '',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(height: 5.0),
                              Text(
                                movie.releaseDate ?? '',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        } else if (state is searchErrorState) {
          return Center(
            child: Text(
              'Error',
              style: TextStyle(color: Colors.red),
            ),
          );
        } else {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.local_movies_sharp,
                    size: 200, color: Colors.white38),
                Text('No Movies Found',
                    style: TextStyle(color: Colors.white60)),
              ],
            ),
          );
        }
      },
    );
  }
}
