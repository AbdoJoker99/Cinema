import 'package:cinema/HomeTab/Data/Response/SimilarDetailsResponse.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'movie_details_screen.dart';

class SimilarMoviesSection extends StatelessWidget {
  final List<Resul>?
      similarMovies; // List of similar movies passed as a parameter

  const SimilarMoviesSection({Key? key, required this.similarMovies})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 10.h),
          child: Text(
            'More Like This',
            style: TextStyle(
              fontSize: 19.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        if (similarMovies != null && similarMovies!.isNotEmpty)
          Container(
            height: 210.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: similarMovies!.length,
              itemBuilder: (context, index) {
                final similarMovie = similarMovies![index];
                return Padding(
                  padding: EdgeInsets.only(left: 17.w),
                  child: GestureDetector(
                    onTap: () {
                      // Handle tap to navigate to movie details
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MovieDetailsScreen(
                            movieId: similarMovie.id!.toInt(),
                          ),
                        ),
                      );
                    },
                    child: Stack(
                      children: [
                        // Movie Poster
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            similarMovie.posterPath != null
                                ? 'https://image.tmdb.org/t/p/w500${similarMovie.posterPath}'
                                : 'https://via.placeholder.com/121x160?text=No+Image',
                            width: 120.w,
                            height: 160.h,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: 120.w,
                                height: 160.h,
                                color: Colors.grey,
                                child: Center(
                                  child: Text(
                                    'Image not available',
                                    style: TextStyle(color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        // Rating (Stars) Positioned at the top
                        Positioned(
                          top: 160.h,
                          left: 10.w,
                          child: Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 17,
                              ),
                              SizedBox(width: 5.w),
                              Text(
                                similarMovie.voteAverage?.toString() ??
                                    "No Rating",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        // Movie Title Positioned at the bottom
                        Positioned(
                          top: 180.h,
                          bottom: 0.h,
                          left: 10.w,
                          right: 10.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                similarMovie.title ?? "",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                      color: Colors.white,
                                      fontSize: 12.sp,
                                    ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
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
          )
        else
          Padding(
            padding: EdgeInsets.all(17.w),
            child: Center(
              child: Text(
                'No similar movies found',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
      ],
    );
  }
}

// Make sure to create a MovieDetailsPage widget to display movie details
class MovieDetailsPage extends StatelessWidget {
  final Resul movie; // Assuming Resul has all the required details

  const MovieDetailsPage({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Replace this with your actual details page layout
    return Scaffold(
      appBar: AppBar(title: Text(movie.title ?? 'Movie Details')),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              movie.title ?? "Unknown title",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(height: 10.h),
            Text('Release Date: ${movie.releaseDate ?? "Unknown"}'),
            // Add more fields and layout according to movie details here
          ],
        ),
      ),
    );
  }
}
