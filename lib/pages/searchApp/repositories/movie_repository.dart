import '../models/movieResponse.dart';
import 'package:dio/dio.dart';

class MovieRepository {
  final String apiKey = "c3de6d2e4acab6944f3c0e0435dcf6c9";
  static String mainUrl = "https://api.themoviedb.org/3/";

  final Dio _dio = Dio();
  var getMoviesUrl = '$mainUrl/discover/movie';
  var getPlayingUrl = '$mainUrl/movie/now_playing';

  Future<MovieResponse> getMovies(query) async {
    var params = {
      'api_key': apiKey,
      'language': 'en-US',
      'page': 1,
      "query": query
    };

    try {
      Response response = await _dio.get(getMoviesUrl, queryParameters: params);
      return MovieResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return MovieResponse.withError("$error");
    }
  }
}
