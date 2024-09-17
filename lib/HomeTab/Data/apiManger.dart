import 'dart:convert';

import 'package:cinema/HomeTab/Data/Response/topRatedOrPopularResponse.dart';
import 'package:http/http.dart' as http;

import 'Response/upComingResponse.dart';
import 'endPoint.dart';

class ApiManager {
  static const String baseUrl = 'api.themoviedb.org';

  static Future<TopRatedOrPopularResponse> getAllTopRated() async {
    Uri url = Uri.https(
      baseUrl,
      EndPoints.topRated,
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

  static Future<TopRatedOrPopularResponse> getAllPopular() async {
    Uri url = Uri.https(
      baseUrl,
      EndPoints.popular,
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

  static Future<UpComingResponse> getAllUpComing() async {
    Uri url = Uri.https(
      baseUrl,
      EndPoints.upComing,
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
}
