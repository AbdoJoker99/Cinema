import 'package:flutter/material.dart';

import '../cubit/Respone/SearchRespone.dart';

class MovieCard extends StatelessWidget {
  final moviess movie;

  const MovieCard({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[900],
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display the movie poster if available
            movie.posterPath != null
                ? Image.network(
                    'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                    width: 100.0,
                    height: 150.0,
                    fit: BoxFit.cover,
                  )
                : Container(
                    width: 100.0,
                    height: 150.0,
                    color: Colors.grey,
                    child: Icon(
                      Icons.local_movies,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
            SizedBox(width: 20.0),
            // Display movie title, release date, and overview
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title ?? 'Unknown Title',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'Release Date: ${movie.releaseDate ?? 'Unknown'}',
                    style: TextStyle(color: Colors.grey[500]),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    movie.overview ?? 'No overview available',
                    style: TextStyle(color: Colors.grey[400]),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
