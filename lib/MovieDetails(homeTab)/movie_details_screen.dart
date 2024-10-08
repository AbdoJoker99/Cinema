import 'package:cinema/MovieDetails(homeTab)/similarMovieSection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../AppColors.dart';
import 'Cubit/movie_details_view_model.dart';
import 'Cubit/movie_states.dart';
import 'MovieDetailsSection.dart';

class MovieDetailsScreen extends StatefulWidget {
  static const String routeName = 'movie_details';
  final int movieId;

  MovieDetailsScreen({required this.movieId});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  late MovieDetailsViewModel cubit;

  // State variables to manage loading and error states
  bool _isLoadingDetails = true;
  String? _detailsErrorMsg;
  bool _isLoadingSimilarMovies = true;
  String? _similarMoviesErrorMsg;

  @override
  void initState() {
    super.initState();
    cubit = MovieDetailsViewModel();
    _fetchData();
  }

  Future<void> _fetchData() async {
    await cubit.getAllDetails(widget.movieId);
    await cubit.getAllSimilarDetails(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.backgroundColor,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: Container(
              padding: EdgeInsets.all(8.0), // Add padding
              decoration: BoxDecoration(
                color:
                    Colors.black.withOpacity(0.2), // Container background color
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back, color: Colors.white),
              ),
            ),
          ),
          body: BlocListener<MovieDetailsViewModel, MovieDetailsStates>(
            listener: (context, state) {
              // Handle loading and error states
              if (state is MovieDetailsLoadingState) {
                setState(() {
                  _isLoadingDetails = true;
                  _detailsErrorMsg = null;
                });
              } else if (state is MovieDetailsErrorState) {
                setState(() {
                  _isLoadingDetails = false;
                  _detailsErrorMsg = state.errorMsg;
                });
              } else if (state is MovieDetailsSuccessState) {
                setState(() {
                  _isLoadingDetails = false;
                  _detailsErrorMsg = null;
                });
              }

              if (state is MovieSimilarDetailsLoadingState) {
                setState(() {
                  _isLoadingSimilarMovies = true;
                  _similarMoviesErrorMsg = null;
                });
              } else if (state is MovieSimilarDetailsErrorState) {
                setState(() {
                  _isLoadingSimilarMovies = false;
                  _similarMoviesErrorMsg = state.errorMsg;
                });
              } else if (state is MovieSimilarDetailsSuccessState) {
                setState(() {
                  _isLoadingSimilarMovies = false;
                  _similarMoviesErrorMsg = null;
                });
              }
            },
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Movie Details Section
                  Container(
                    padding:
                        EdgeInsets.all(16.0), // Add padding to the container
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.05), // Background color
                      borderRadius:
                          BorderRadius.circular(12.0), // Rounded corners
                    ),
                    child: _isLoadingDetails
                        ? Center(child: CircularProgressIndicator())
                        : _detailsErrorMsg != null
                            ? Container(
                                height: 215.0,
                                alignment: Alignment.center,
                                child: Text(
                                  'Failed to load movie details: $_detailsErrorMsg',
                                  style: TextStyle(color: Colors.red),
                                ),
                              )
                            : MovieDetailsSection(
                                movieId: widget.movieId,
                                movie: cubit
                                    .movieDetails, // Pass movie details here
                              ),
                  ),

                  SizedBox(height: 10.0.h), // Space between sections

                  // Similar Movies Section
                  Container(
                    padding:
                        EdgeInsets.all(16.0), // Add padding to the container
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.05), // Background color
                      borderRadius:
                          BorderRadius.circular(12.0), // Rounded corners
                    ),
                    child: _isLoadingSimilarMovies
                        ? Center(child: CircularProgressIndicator())
                        : _similarMoviesErrorMsg != null
                            ? Container(
                                height: 215.0,
                                alignment: Alignment.center,
                                child: Center(
                                  child: Text(
                                    'Failed to load similar movies: $_similarMoviesErrorMsg',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              )
                            : SimilarMoviesSection(
                                similarMovies: cubit.similarDetails
                                    .results, // Pass similar movies here
                              ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
