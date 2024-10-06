import 'dart:convert';

import 'package:cinema/BrowserScreen/dataBrowser/responseBrowser/browserDiscoveryRespone.dart';
import 'package:cinema/BrowserScreen/dataBrowser/responseBrowser/browserResponse.dart';
import 'package:http/http.dart' as http;

import 'browserEndPoint.dart';

class ApibrowserManger {
  static const String baseUrl = 'api.themoviedb.org';
  static const String apiKey = '0fac6e38b1f771ab5508dd888b0c593c';

  // Get all Top Rated movies
  static Future<BrowserResponse> getAllMovielList() async {
    Uri url = Uri.https(baseUrl, browserEndPoints.movieList, {
      'api_key': apiKey,
    });
    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        print('API Response: $json');
        return BrowserResponse.fromJson(json);
      } else {
        throw Exception(
            'Failed to load movies. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
      throw e;
    }
  }

  static Future<BrowserDiscoveryResponse> getAllDiscoveryMovieList(
      String genderId) async {
    Uri url = Uri.https(baseUrl, browserEndPoints.DiscoverMovieList,
        {'api_key': apiKey, 'with_genres': genderId});
    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        print('API Response: $json');
        return BrowserDiscoveryResponse.fromJson(json);
      } else {
        throw Exception(
            'Failed to load movies. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
      throw e;
    }
  }

  Future<List<reselt>> fetchSimilarMovies(int movieId) async {
    final url = Uri.https('$baseUrl/movie/$movieId/similar?api_key=$apiKey');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List<reselt> similarMovies = (data['results'] as List)
            .map((movie) => reselt.fromJson(movie))
            .toList();
        return similarMovies;
      } else {
        throw Exception("Failed to load similar movies");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
