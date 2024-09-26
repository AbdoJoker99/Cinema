import 'dart:convert';

import 'package:cinema/HomeTab/Data/Response/topRatedOrPopularResponse.dart';
import 'package:http/http.dart' as http;

import 'Response/DetailsResponse.dart';
import 'Response/SimilarDetailsResponse.dart';
import 'Response/upComingResponse.dart';
import 'endPoint.dart';

class ApiManager {
  static const String baseUrl = 'api.themoviedb.org';
  static const String apiKey =
      '0fac6e38b1f771ab5508dd888b0c593c'; // Add your API key here
  static const String language =
      'en-US'; // You can change the language if needed
  static const String page = '1'; // Set the page number (or make it dynamic)

  // Get all Top Rated movies
  static Future<TopRatedOrPopularResponse> getAllTopRated() async {
    Uri url = Uri.https(
      baseUrl,
      EndPoints.topRated,
      {
        'api_key': apiKey,
        'language': language,
        'page': page,
      },
    );
    try {
      var response = await http.get(url);
      var bodyString = response.body;
      var json = jsonDecode(bodyString);

      return TopRatedOrPopularResponse.fromJson(json);
    } catch (e) {
      throw e;
    }
  }

  // Get all Popular movies
  static Future<TopRatedOrPopularResponse> getAllPopular() async {
    Uri url = Uri.https(
      baseUrl,
      EndPoints.popular,
      {
        'api_key': apiKey,
        'language': language,
        'page': page,
      },
    );
    try {
      var response = await http.get(url);
      var bodyString = response.body;
      var json = jsonDecode(bodyString);

      return TopRatedOrPopularResponse.fromJson(json);
    } catch (e) {
      throw e;
    }
  }

  // Get all Upcoming movies
  static Future<UpComingResponse> getAllUpComing() async {
    Uri url = Uri.https(
      baseUrl,
      EndPoints.upComing,
      {
        'api_key': apiKey,
        'language': language,
        'page': page,
      },
    );
    try {
      var response = await http.get(url);
      var bodyString = response.body;
      var json = jsonDecode(bodyString);

      return UpComingResponse.fromJson(json);
    } catch (e) {
      throw e;
    }
  }

  static Future<DetailsResponse> getAllDetails(int movieId) async {
    Uri url = Uri.https(
      baseUrl,
      '${EndPoints.details}/$movieId',
      {
        'api_key': apiKey,
        'language': language,
      },
    );
    try {
      var response = await http.get(url);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        var bodyString = response.body;
        var json = jsonDecode(bodyString);
        return DetailsResponse.fromJson(json);
      } else {
        print('response body:${response.body}');
        throw Exception('Failed to load movie details: ${response.statusCode}');
      }
    } catch (e) {
      print('Error details:$e');
      throw Exception('Error fetching movie details: $e');
    }
  }

  // Get similar movies
  static Future<SimilarDetailsResponse> getAllSimilarDetails(
      int movieId) async {
    Uri url = Uri.https(
      baseUrl,
      '${EndPoints.similarDetails}/$movieId/similar',
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
        return SimilarDetailsResponse.fromJson(json);
      } else {
        throw Exception(
            'Failed to load similar movies: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching similar movies: $e');
    }
  }

  static String getMovieReleaseYear(String data) {
    return data.split('-')[0];
  }
}
