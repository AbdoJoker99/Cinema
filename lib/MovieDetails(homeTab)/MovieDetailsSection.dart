import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MovieDetailsSection extends StatelessWidget {
  final int movieId;
  final dynamic movie; // Accept the movie details directly

  const MovieDetailsSection(
      {Key? key, required this.movieId, required this.movie})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.all(16.w),
      child: _buildMovieDetails(movie),
    );
  }

  Widget _buildMovieDetails(dynamic movie) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Image.network(
              movie.posterPath != null
                  ? 'https://image.tmdb.org/t/p/w500${movie.posterPath}'
                  : 'https://via.placeholder.com/500x250?text=No+Image',
              width: double.infinity,
              height: 250.h,
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
                  onPressed: () {
                    // Implement your play button action
                  },
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        Text(
          movie.title ?? "No Title Available",
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          '${movie.releaseDate ?? "No release date"}, ${movie.runtime != null ? "${movie.runtime} mins" : "No runtime"}',
          style: TextStyle(fontSize: 14.sp, color: Colors.grey),
        ),
        SizedBox(height: 10.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                movie.posterPath != null
                    ? 'https://image.tmdb.org/t/p/w500${movie.posterPath}'
                    : 'https://via.placeholder.com/100x150?text=No+Image',
                width: 129.w,
                height: 220.h,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Center(child: Text('Image failed to load'));
                },
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 6.w,
                    runSpacing: 6.h,
                    children: movie.genres != null
                        ? movie.genres.map<Widget>((genre) {
                            return Chip(
                              label: Text(genre.name!),
                              backgroundColor: Colors.grey.shade400,
                            );
                          }).toList()
                        : [
                            Chip(label: Text("No Genres"))
                          ], // Fallback if genres are null
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    movie.overview ?? "No description available",
                    maxLines: 2,
                    overflow: TextOverflow.fade,
                    style:
                        TextStyle(color: Colors.grey.shade300, fontSize: 14.sp),
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
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
