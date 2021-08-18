import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:movie_db/models/movie.dart';
import 'package:movie_db/tools/helper_functions.dart'
    show getJsonFromRootBundle, tokenizeString;
import 'package:movie_db/screens/add_movie.dart' show AddMoviePage;

List<Movie> parseMovies(String responseBody) {
  final parsed =
      jsonDecode(responseBody)['Search'].cast<Map<String, dynamic>>();
  return parsed.map<Movie>((json) => Movie.fromJson(json)).toList();
}

Future<String> getApiUrl() async {
  final baseUrl =
      jsonDecode(await getJsonFromRootBundle())['OMDB_API_ENDPOINT'];
  return baseUrl + '&type=movie';
}

Future<List<Movie>> fetchMovies(http.Client client) async {
  String apiUrl = await getApiUrl();
  final searchQuery = tokenizeString('Fast and the Furious');
  final response = await client.get(Uri.parse(apiUrl + '&s=$searchQuery'));
  return compute(parseMovies, response.body);
}

class MoviesPage extends StatelessWidget {
  const MoviesPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Movie>>(
        future: fetchMovies(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Could not fetch movies :/'),
            );
          } else if (snapshot.hasData) {
            return MoviesList(movies: snapshot.data!);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddMoviePage()),
          );
        },
      ),
    );
  }
}

class MoviesList extends StatelessWidget {
  const MoviesList({Key? key, required this.movies}) : super(key: key);

  final List<Movie> movies;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: movies.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Image.network(
              movies[index].posterUrl,
              errorBuilder: (context, exception, stackTrace) {
                final title = movies[index].title;
                return Text("Poster not found for movie: $title");
              },
            ),
          ),
        );
      },
    );
  }
}
