import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../firebase_utils.dart';
import '../Data/Response/upComingResponse.dart'; // Import your upcoming data model here

class Upcomingitem extends StatefulWidget {
  final upComing? upcoming; // Declare the movie data (optional)
  Upcomingitem({Key? key, required this.upcoming})
      : super(key: key); // Pass the movie data to the widget

  @override
  State<Upcomingitem> createState() => _UpcomingitemState();
}

class _UpcomingitemState extends State<Upcomingitem> {
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _loadIconState();
    _checkWatchlistStatus();
  }

  void _loadIconState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isFavorite = prefs.getBool('isFavorite_${widget.upcoming?.id}') ?? false;
    });
  }

  void _saveIconState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isFavorite_${widget.upcoming?.id}', _isFavorite);
  }

  void dispose() {
    // Cancel any async tasks or timers here
    super.dispose();
  }

  void _checkWatchlistStatus() async {
    // Perform async operation here
    if (!mounted)
      return; // Prevent setState from being called if the widget is not mounted
    setState(() {
      // Your state update logic here
    });
  }

  @override
  Widget build(BuildContext context) {
    final movie = widget.upcoming; // Access movie data

    return Stack(
      children: [
        // Display the main image (e.g., the background image)
        Container(
          margin: EdgeInsets.all(10),
          height: 140.h, // Set the image height
          width: 100.w, // Set the image width
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                'https://image.tmdb.org/t/p/w500${movie?.posterPath ?? ""}',
              ), // Main image path from the movie data
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(
                10), // Add a border radius for rounded edges
          ),
        ),
        // The tappable icon image overlaid on the main image
        Positioned(
          left: 10.w,
          top: 10.h,
          child: GestureDetector(
            onTap: () async {
              setState(() {
                _isFavorite = !_isFavorite;
                _saveIconState();
              });

              if (_isFavorite) {
                await Firestore.addMovieToFirestore(
                    context,
                    movie?.title ?? '',
                    'https://image.tmdb.org/t/p/w500${movie?.posterPath}' ?? '',
                    movie?.releaseDate ?? '');
              } else {
                await Firestore.removeMovieByTitle(movie?.title ?? '');
              }
            },
            child: Image.asset(
              _isFavorite
                  ? 'assets/images/Icon awesome-bookmark.png'
                  : 'assets/images/bookmark.png',
              width: 30.w,
              height: 40.h,
            ),
          ),
        )
        // Add movie title at the bottom
      ],
    );
  }
}
