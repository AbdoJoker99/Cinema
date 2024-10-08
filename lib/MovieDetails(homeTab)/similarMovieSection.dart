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
          padding: EdgeInsets.all(17.w),
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
            height: 201.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: similarMovies!.length,
              itemBuilder: (context, index) {
                final similarMovie = similarMovies![index];
                return Padding(
                  padding: EdgeInsets.only(left: 17.w),
                  child: GestureDetector(
                    // Wrap with GestureDetector
                    onTap: () {
                      // Handle tap to navigate to movie details
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MovieDetailsScreen(
                                  movieId: similarMovies![index].id!.toInt())));
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                          similarMovie.posterPath != null
                              ? 'https://image.tmdb.org/t/p/w500${similarMovie.posterPath}'
                              : 'https://via.placeholder.com/121x160?text=No+Image',
                          width: 120.w,
                          height: 140.h,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Center(
                              child: Text('Image failed to load'),
                            );
                          },
                        ),
                        SizedBox(height: 9.h),
                        Row(
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
                                fontSize: 15.sp,
                              ),
                            ),
                          ],
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
      body: Center(
        child: Text('Details for ${movie.title}'),
      ),
    );
  }
}
