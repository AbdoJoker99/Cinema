import 'package:cinema/HomeTab/widgets/popularItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Data/Response/topRatedOrPopularResponse.dart';

class MovieCard extends StatefulWidget {
  final topRatedOrPopular? moviecard; // Added 'final' here for immutability

  MovieCard({Key? key, required this.moviecard}) : super(key: key);
  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  // Fixed constructor
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Ensure the card takes full width of its parent
      height: 275.h, // Set a specific height for the card
      child: Stack(
        children: [
          // Movie Poster and Background with some opacity
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 70.h, // Adjust this bottom position
            child: Opacity(
              opacity: 0.8, // Adjust this as needed
              child: Image.asset(
                'https://image.tmdb.org/t/p/w500${widget.moviecard?.backdropPath}', // Use moviecard backdrop image dynamically
                width: double.infinity, // Full width of the screen
                height: 250.h, // Set a specific height for the card
                fit: BoxFit
                    .cover, // Ensure the image covers the entire container
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/images/Image.png', // Placeholder image if backdrop fails
                    width: double.infinity,
                    height: 250.h,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
          ),
          // Overlaying Play Button and Movie Info
          Positioned(
            top: 50.h, // Align this block to the bottom of the container
            left: 0,
            right: 0, // Center the content horizontally
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Play Button Overlay
                InkWell(
                  onTap: () {
                    // Add your navigation logic here (e.g., navigate to description page)
                  },
                  child: Container(
                    width: 50.w,
                    height: 50.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      'assets/images/play-button-2.png', // Replace with your image path for play button
                      width: 60.w, // Adjust the play button size
                      height: 60.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.h), // Space between the play button and text
          // Movie title and release date inside a container
          Positioned(
            right: 10.w,
            top: 210.h,
            child: Container(
              width: 250.w,
              height: 100.h, // Adjust this width based on your design needs
              padding: EdgeInsets.symmetric(
                  vertical: 5.h), // Padding for the text container
              child: Column(
                children: [
                  // Movie Title
                  Text(
                    widget.moviecard?.title ??
                        'Unknown Title', // Dynamic movie title
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Colors.white, // Set text color to white
                          fontWeight:
                              FontWeight.bold, // Add bold styling for title
                        ),
                    maxLines: 1, // Limit title to a single line
                    overflow: TextOverflow
                        .ellipsis, // Add ellipsis if title overflows
                    textAlign: TextAlign.center, // Center align the title text
                  ),
                  // Movie Date and Details
                  Text(
                    '${widget.moviecard?.releaseDate ?? ''} • PG-13 • 2h 7m', // Dynamic release date
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Colors.white70, // Lighter text for the details
                        ),
                    textAlign:
                        TextAlign.center, // Center align the details text
                  ),
                ],
              ),
            ),
          ),
          // Positioned smaller image at the bottom-left
          Positioned(
            top: 95.h,
            bottom: 0.h, // Adjust bottom position as needed
            left: 10.w, // Adjust left position as needed
            child: Container(
              width: 120.w,
              height: 220.h, // Adjust the size to match the smaller image size
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                    8), // Add rounded corners if necessary
              ),
              child: popularitem(
                moviecard: null,
              ), // This is your custom widget for the smaller image
            ),
          ),
        ],
      ),
    );
  }
}
