import 'dart:convert';

import 'package:http/http.dart' as http;

import 'Respone/SearchRespone.dart';
import 'endpoints.dart';

class ApiSearchManager {
  static const String baseUrl = 'api.themoviedb.org';
  static const String apiKey = '34e003d4b9d026a15d3cc1a2ce2c3fd2';
  static const String language = 'en-US';
  static const String page = '1';

  static Future<MovieResponse> getMovieResponse(int movieId) async {
    Uri url = Uri.https(
      baseUrl,
      '${EndpointSearch.search}/$movieId/similar',
      {
        'api_key': apiKey,
        'language': language,
        'page': page,
      },
    );
    try {
      var response = await http.get(url);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        var bodyString = response.body;
        var json = jsonDecode(bodyString);
        return MovieResponse.fromJson(json);
      } else {
        throw Exception(
            'Failed to load similar movies: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching similar movies: $e');
    }
  }

  static Future<MovieResponse> searchMovies(String query) async {
    final apiKey = "092d1e0bb1cb68908930364d656c5a41";
    final url = Uri.parse(
        "https://api.themoviedb.org/3/search/movie?api_key=$apiKey&query=$query");

    try {
      final response = await http.get(url);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        var bodyString = response.body;
        var json = jsonDecode(bodyString);

        return MovieResponse.fromJson(json);
      } else {
        throw Exception(
            'Failed to load search results: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching search results: $e');
    }
  }
}
