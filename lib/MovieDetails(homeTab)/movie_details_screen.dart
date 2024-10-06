import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../AppColors.dart';
import 'Cubit/movie_details_view_model.dart';
import 'Cubit/movie_states.dart';
import 'MovieDetailsSection.dart';
import 'similarMovieDetails.dart';

class MovieDetailsScreen extends StatelessWidget {
  static const String routeName = 'movie_details';
  final int movieId;

  MovieDetailsScreen({required this.movieId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MovieDetailsViewModel()..getAllDetails(movieId),
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back, color: Colors.white),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(8.0.w),
          child: BlocBuilder<MovieDetailsViewModel, MovieDetailsStates>(
            builder: (context, state) {
              if (state is MovieDetailsLoadingState) {
                return Center(child: CircularProgressIndicator());
              } else if (state is MovieDetailsErrorState) {
                return Center(
                    child: Text(state.errorMsg,
                        style: TextStyle(color: Colors.red)));
              } else if (state is MovieDetailsSuccessState) {
                // Show movie details
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Movie Details Section
                      MovieDetailsSection(
                          movieId: movieId, movie: state.details),
                      Divider(color: Colors.grey.shade800),
                      // Similar Movies Section
                      BlocBuilder<MovieDetailsViewModel, MovieDetailsStates>(
                        builder: (context, similarState) {
                          if (similarState is MovieSimilarDetailsLoadingState) {
                            return Center(child: CircularProgressIndicator());
                          } else if (similarState
                              is MovieSimilarDetailsErrorState) {
                            return Center(
                                child: Text(similarState.errorMsg,
                                    style: TextStyle(color: Colors.red)));
                          } else if (similarState
                              is MovieSimilarDetailsSuccessState) {
                            return SimilarMoviesSection(
                                similarMovies: similarState.similarDetails);
                          } else {
                            return Center(
                                child: Text('No similar movies found'));
                          }
                        },
                      ),
                    ],
                  ),
                );
              }
              return Center(child: Text('Something went wrong'));
            },
          ),
        ),
      ),
    );
  }
}
