import 'package:tradexa/src/models/movie_list_response.dart';
import 'package:tradexa/src/resources/api_providers/auth_api_provider.dart';

class Repository {
  final movieApiProvider = MovieApiProvider();

  Future<MovieListResponse> getMovies(movieName) =>
      movieApiProvider.getMovies(movieName);
}
