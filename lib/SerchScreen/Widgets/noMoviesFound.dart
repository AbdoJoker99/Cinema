import 'package:flutter/material.dart';

class NoMoviesFound extends StatelessWidget {
  final String text;

  const NoMoviesFound({Key? key, this.text = 'No movies found'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.local_movies,
          size: 100,
          color: Colors.blue,
        ),
        SizedBox(height: 20),
        Text(
          text,
          style: TextStyle(
            color: Colors.blue,
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}
