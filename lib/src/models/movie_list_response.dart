// To parse this JSON data, do
//
//     final movieListResponse = movieListResponseFromJson(jsonString);

import 'dart:convert';

class MovieListResponse {
  final String title;
  final String genre;
  final String poster;
  final String imdbRating;

  MovieListResponse({
    this.title,
    this.genre,
    this.poster,
    this.imdbRating,
  });

  factory MovieListResponse.fromJson(String str) => MovieListResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MovieListResponse.fromMap(Map<String, dynamic> json) => MovieListResponse(
    title: json["Title"] == null ? null : json["Title"],
    genre: json["Genre"] == null ? null : json["Genre"],
    poster: json["Poster"] == null ? null : json["Poster"],
    imdbRating: json["imdbRating"] == null ? null : json["imdbRating"],
  );

  Map<String, dynamic> toMap() => {
    "Title": title == null ? null : title,
    "Genre": genre == null ? null : genre,
    "Poster": poster == null ? null : poster,
    "imdbRating": imdbRating == null ? null : imdbRating,
  };
}
