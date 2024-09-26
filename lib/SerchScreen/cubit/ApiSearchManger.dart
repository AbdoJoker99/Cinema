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
    Uri url = Uri.https(baseUrl, '3/search/movie', {'query': query});
    var headers = {
      'accept': 'application/json',
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlN2MzOGFjMmFkNDZlMTNjZWRkZmJkODY4MWVmMDljNiIsIm5iZiI6MTcyNjU4MzMwMi4zMzU0NDEsInN1YiI6IjY2ZTk5MDEyMWJlY2E4Y2UwN2QyZTliYyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.yfWSVG40lcpxu1MYOZOUEwY_15NdwS7JvIfDrFsEMhs'
    };
    try {
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        return MovieResponse.fromJson(json.decode(response.body));
      } else {
        throw Exception("${response.statusCode}");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
