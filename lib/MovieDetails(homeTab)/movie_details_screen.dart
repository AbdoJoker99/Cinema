import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../AppColors.dart';
import 'Cubit/movie_details_view_model.dart';
import 'Cubit/movie_states.dart';

class MovieDetailsScreen extends StatelessWidget {
  static const String routeName = 'movie_details';
  final int movieId;

  MovieDetailsScreen({required this.movieId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = MovieDetailsViewModel()
          ..getAllDetails(movieId)
          ..getAllSimilarDetails(movieId);
        return cubit;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.backgroundColor,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<MovieDetailsViewModel, MovieDetailsStates>(
                  builder: (context, state) {
                    if (state is MovieDetailsLoadingState) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is MovieDetailsSuccessState) {
                      return _buildMovieDetails(state.details);
                    } else if (state is MovieDetailsErrorState) {
                      return Center(child: Text(state.errorMsg));
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
                SizedBox(height: 20.h), // Add some space between the sections
                BlocBuilder<MovieDetailsViewModel, MovieDetailsStates>(
                  builder: (context, state) {
                    if (state is MovieSimilarDetailsLoadingState) {
                      return Container(
                        height: 200.h,
                        child: Center(child: CircularProgressIndicator()),
                      );
                    } else if (state is MovieSimilarDetailsSuccessState) {
                      return _buildSimilarMoviesSection(
                          state.similarDetails.results!);
                    } else if (state is MovieSimilarDetailsErrorState) {
                      return Center(child: Text(state.errorMsg));
                    } else {
                      return SizedBox.shrink();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMovieDetails(movie) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          height: 250.h, // Fixed height for movie poster
          child: Stack(
            children: [
              Image.network(
                movie.posterPath != null
                    ? 'https://image.tmdb.org/t/p/w500${movie.posterPath}'
                    : 'https://via.placeholder.com/500x250?text=No+Image',
                width: double.maxFinite,
                height: 400.h,
                fit: BoxFit.fill,
                errorBuilder: (context, error, stackTrace) {
                  return Center(child: Text('Image failed to load'));
                },
              ),
              Positioned(
                left: 176.w,
                bottom: 78.h,
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: IconButton(
                    icon: Icon(Icons.play_arrow, size: 30),
                    onPressed: () {},
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                movie.title ?? "No Title Available",
                style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(height: 8.h),
              Text(
                '${movie.releaseDate ?? "No release date"}, ${movie.runtime != null ? "${movie.runtime} mins" : "No runtime"}',
                style: TextStyle(fontSize: 14.sp, color: Colors.grey),
              ),
              SizedBox(height: 10.h),
              Wrap(
                spacing: 6.w,
                runSpacing: 6.h,
                children: movie.genres!.map<Widget>((genre) {
                  return Chip(
                    label: Text(genre.name!),
                    backgroundColor: Colors.grey.shade400,
                  );
                }).toList(),
              ),
              SizedBox(height: 10.h),
              Text(
                movie.overview ?? "No description available",
                style: TextStyle(color: Colors.grey.shade300, fontSize: 14.sp),
              ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  Icon(Icons.star, color: Colors.amber),
                  SizedBox(width: 5.w),
                  Text(
                    movie.voteAverage?.toString() ?? "No Rating",
                    style: TextStyle(fontSize: 16.sp, color: Colors.white),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Divider(color: Colors.grey.shade800),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSimilarMoviesSection(List similarDetails) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(16.w),
          child: Text(
            'More Like This',
            style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
        Container(
          height: 200.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: similarDetails.length,
            itemBuilder: (context, index) {
              final similarDetail = similarDetails[index];

              return Padding(
                padding: EdgeInsets.only(left: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      similarDetail.posterPath != null
                          ? 'https://image.tmdb.org/t/p/w500${similarDetail.posterPath}'
                          : 'https://via.placeholder.com/120x160?text=No+Image',
                      width: 120.w,
                      height: 160.h,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Center(child: Text('Image failed to load'));
                      },
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 16),
                        SizedBox(width: 4.w),
                        Text(
                          similarDetail.voteAverage?.toString() ?? "No Rating",
                          style:
                              TextStyle(color: Colors.white, fontSize: 14.sp),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        SizedBox(height: 20.h),
      ],
    );
  }
}
