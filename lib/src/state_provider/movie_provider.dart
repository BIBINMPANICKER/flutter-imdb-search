import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:tradexa/src/models/movie_list_response.dart';
import 'package:tradexa/src/object_factory.dart';
import 'package:tradexa/src/utils/utils.dart';

class MovieProvider with ChangeNotifier {
  String quote = 'Please search with movie name...';
  bool isLoading = false;
  MovieListResponse movieListResponse = MovieListResponse();

  getMovies(movieName) async {
    try {
      isLoading = true;
      notifyListeners(); //for starting loading animation on search
      //check the internet connectivity
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        movieListResponse =
            await ObjectFactory().repository.getMovies(movieName);
        // if there is no movies with the given query
        if (movieListResponse.results.length == 0) {
          movieListResponse.results = null;
          quote = 'No Movies Found...';
        }
        isLoading = false;
        notifyListeners(); //updating the list view
      }
    } on SocketException catch (_) {
      isLoading = false;
      notifyListeners(); //stop loading animation
      toast(msg: 'Check your Internet Connection');
    }
  }
}
