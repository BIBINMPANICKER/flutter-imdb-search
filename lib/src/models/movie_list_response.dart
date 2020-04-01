// To parse this JSON data, do
//
//     final movieListResponse = movieListResponseFromJson(jsonString);

import 'dart:convert';

MovieListResponse movieListResponseFromJson(String str) =>
    MovieListResponse.fromMap(json.decode(str));

String movieListResponseToJson(MovieListResponse data) =>
    json.encode(data.toMap());

class MovieListResponse {
  List<Result> results = <Result>[];

  MovieListResponse({
    this.results,
  });

  factory MovieListResponse.fromMap(Map<String, dynamic> json) =>
      MovieListResponse(
        results: json["results"] == null
            ? null
            : List<Result>.from(json["results"].map((x) => Result.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "results": results == null
            ? null
            : List<dynamic>.from(results.map((x) => x.toMap())),
      };
}

class Result {
  String posterPath;
  List<int> genreIds;
  String title;
  double voteAverage;

  Result({
    this.posterPath,
    this.genreIds,
    this.title,
    this.voteAverage,
  });

  factory Result.fromMap(Map<String, dynamic> json) => Result(
        posterPath: json["poster_path"] == null ? null : json["poster_path"],
        genreIds: json["genre_ids"] == null
            ? null
            : List<int>.from(json["genre_ids"].map((x) => x)),
        title: json["title"] == null ? null : json["title"],
        voteAverage: json["vote_average"] == null
            ? null
            : json["vote_average"].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "poster_path": posterPath == null ? null : posterPath,
        "genre_ids": genreIds == null
            ? null
            : List<dynamic>.from(genreIds.map((x) => x)),
        "title": title == null ? null : title,
        "vote_average": voteAverage == null ? null : voteAverage,
      };
}
