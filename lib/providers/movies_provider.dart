
import 'package:flutter/material.dart';

class MoviesProvider extends ChangeNotifier {

  MoviesProvider() {
    print('Movies provider initialized');

    getOnDisplayMovies();

  }

  getOnDisplayMovies() async {
    print('getOnDisplayMovies');
  }

}