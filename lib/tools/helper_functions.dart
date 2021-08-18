import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'package:http/http.dart' as http;
import 'package:movie_db/models/movie.dart' show Movie;

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

Future<List<Movie>> fetchMoviesFromSearch(http.Client client) async {
  String apiUrl = await getApiUrl();
  final searchQuery = tokenizeString('Interstellar');
  final response = await client.get(Uri.parse(apiUrl + '&s=$searchQuery'));
  return compute(parseMoviesFromSearch, response.body);
}
