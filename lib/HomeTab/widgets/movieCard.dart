import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../MovieDetails(homeTab)/movie_details_screen.dart';
import '../Data/Response/topRatedOrPopularResponse.dart';
import 'card.dart';

class MovieList extends StatefulWidget {
  final List<topRatedOrPopular> movieList; // List of movies
  MovieList({Key? key, required this.movieList}) : super(key: key);

  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  List<topRatedOrPopular> _movies = [];

  @override
  void initState() {
    super.initState();
    _movies = widget.movieList; // Initialize with the provided list

    // Set a timer to update the movie list every second
    Timer.periodic(Duration(seconds: 2), (Timer timer) {
      setState(() {
        _movies.shuffle();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: _movies.length, // Number of movies in the list
      itemBuilder: (context, index, realIndex) {
        return InkWell(
          onTap: () {
            MaterialPageRoute(
                builder: (context) =>
                    MovieDetailsScreen(movieId: _movies[index].id!.toInt()));
          },
          child: MovieCard(
            moviecard: _movies[index], // Pass each movie to MovieCard
          ),
        );
      },
      options: CarouselOptions(
        height: 300.h,
        enlargeCenterPage: true,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 2),
        viewportFraction: 0.8,
        aspectRatio: 16 / 9,
        initialPage: 0,
      ),
    );
  }
}
