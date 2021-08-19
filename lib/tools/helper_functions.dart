import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'package:http/http.dart' as http;
import 'package:movie_db/models/movie_model.dart' show Movie;

String tokenizeString(String param) {
  return param.split(' ').join('+');
}

Future<String> getJsonFromRootBundle() {
  return rootBundle.loadString('secrets.json');
}

Future<String> getApiUrl() async {
  final baseUrl =
      jsonDecode(await getJsonFromRootBundle())['OMDB_API_ENDPOINT'];
  return baseUrl + '&type=movie';
}

List<Movie> parseMoviesFromSearch(String responseBody) {
  final parsed =
      jsonDecode(responseBody)['Search'].cast<Map<String, dynamic>>();
  return parsed.map<Movie>((json) => Movie.fromJson(json)).toList();
}

// HACK: returns a List because fetchMovies needs a list
List<Movie> parseMovieFromTitle(String responseBody) {
  return [Movie.fromJson(jsonDecode(responseBody))];
}

Future<List<Movie>> fetchMovies(http.Client client, String searchStringOrTitle,
    {String queryParam = '&t'}) async {
  String apiUrl = await getApiUrl();
  final searchQuery = tokenizeString(searchStringOrTitle);

  final response =
      await client.get(Uri.parse(apiUrl + '$queryParam=$searchQuery'));

  if (queryParam == '&s') {
    return compute(parseMoviesFromSearch, response.body);
  } else {
    return compute(parseMovieFromTitle, response.body);
  }
}

Future<Movie> fetchMovieFromTitle(http.Client client, String title) async {
  final List<Movie> movies = await fetchMovies(client, title);
  return movies[0];
}

Future<Movie> fetchMovieFromImdbId(http.Client client, String imdbId) async {
  final List<Movie> movies =
      await fetchMovies(client, imdbId, queryParam: '&i');
  return movies[0];
}

Future<List<Movie>> fetchMoviesFromSearch(
    http.Client client, String searchString) async {
  return await fetchMovies(client, searchString, queryParam: '&s');
}
