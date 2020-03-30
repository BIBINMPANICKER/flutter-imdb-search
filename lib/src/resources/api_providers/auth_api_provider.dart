import 'package:tradexa/src/models/movie_list_response.dart';

import '../../object_factory.dart';

class MovieApiProvider {
  Future<MovieListResponse> getMovies(movieName) async {
    final response = await ObjectFactory().apiClient.getMovies(movieName);

    if (response.statusCode == 200) {
      return MovieListResponse.fromMap(response.data);
    } else {
      return null;
    }
  }
}
