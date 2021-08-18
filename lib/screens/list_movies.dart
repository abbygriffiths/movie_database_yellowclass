import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:movie_db/models/movie.dart' show Movie;
import 'package:movie_db/tools/helper_functions.dart'
    show fetchMoviesFromSearch;
import 'package:movie_db/screens/add_movie.dart' show AddMoviePage;
import 'package:movie_db/widgets/error_or_no_connection.dart'
    show ErrorOrNoConnectionPage;
import 'package:movie_db/widgets/movies_list.dart' show MoviesList;

class ListMoviesPage extends StatelessWidget {
  const ListMoviesPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listing Movies'),
      ),
      body: FutureBuilder<List<Movie>>(
        future: fetchMoviesFromSearch(http.Client(), 'Interstellar'),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const ErrorOrNoConnectionPage();
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
        child: const Icon(Icons.add),
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
