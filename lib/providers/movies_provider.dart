import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:movies/models/models.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


class MoviesProvider extends ChangeNotifier {

  final String? _apiKey   = dotenv.env['APIKEYDB'];
  final String _baseUrl  = 'api.themoviedb.org';
  final String _language = 'en-US';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies   = [];

  Map<int, List<Cast>> moviesCast = {};

  int _popularPage = 0;

  MoviesProvider() {
    getOnDisplayMovies();
    getPopularMovies();
  }

  Future<String> _getJsonData( String endpoint, [int page = 1] ) async {
    var url = Uri.https(_baseUrl, endpoint, {
      'api_key': _apiKey,
      'language': _language,
      'page': '$page'
      
    });
    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url);
    return response.body;
  }

  getOnDisplayMovies() async {
    final dataResponse = await _getJsonData('3/movie/now_playing');
    final nowPlayingResponse = NowPlayingResponse.fromJson( dataResponse );

    onDisplayMovies = nowPlayingResponse.results;

    notifyListeners();
  }

  getPopularMovies() async {
    _popularPage++;
    final dataResponse = await _getJsonData('3/movie/popular', _popularPage);
    final popularResponse = PopularResponse.fromJson(dataResponse);

    popularMovies = [ ...popularMovies ,...popularResponse.results];
    notifyListeners();
  }

  Future<List<Cast>> getMovieCast( int movieId ) async {

    print('info al server');
    final dataResponse    = await _getJsonData('3/movie/$movieId/credits');
    final creditsResponse = CreditsResponse.fromJson( dataResponse );

    moviesCast[movieId] = creditsResponse.cast;

    return creditsResponse.cast;

  }

}