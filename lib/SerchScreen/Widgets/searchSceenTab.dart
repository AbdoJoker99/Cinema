import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../HomeTab/widgets/movieCard.dart';
import '../cubit/Respone/SearchRespone.dart';

class Search extends StatefulWidget {
  static const String routeName = 'search';
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String _searchText = "";
  List<Results> _searchResults = [];
  bool _isLoading = false;

  void _onSearch(String text) {
    setState(() {
      _searchText = text;
    });
    _searchMovies(text);
  }

  Future<void> _searchMovies(String query) async {
    setState(() {
      _isLoading = true;
    });

    final apiKey = "092d1e0bb1cb68908930364d656c5a41";
    final url = Uri.parse(
        "https://api.themoviedb.org/3/configuration=$apiKey&query=$query");

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final searchResponse = MovieResponse();

      setState(() {
        _searchResults = searchResponse.results ?? [];
        _isLoading = false;
      });
    } else {
      print("Failed to fetch movies: ${response.statusCode}");
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 50.0),
              child: SearchBar(onSearch: _onSearch),
            ),
            Expanded(
              child: _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : _searchText.isEmpty
                      ? Center(child: NoMoviesFound())
                      : _searchResults.isEmpty
                          ? Center(
                              child: NoMoviesFound(text: 'No results found'))
                          : ListView.builder(
                              itemCount: _searchResults.length,
                              itemBuilder: (context, index) {
                                final movie = _searchResults[index];
                                return MovieCard(moviecard: movie);
                              },
                            ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  final Function(String) onSearch;

  const SearchBar({Key? key, required this.onSearch}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (text) => onSearch(text),
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: 'Search',
        hintStyle: const TextStyle(color: Colors.blue),
        prefixIcon: const Icon(Icons.search, color: Colors.blue),
        filled: true,
        fillColor: Colors.grey[800],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

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
