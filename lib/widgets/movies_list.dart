import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:movie_db/models/movie.dart' show Movie;

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
                return Image.asset('images/movie_poster_not_found.jpg');
              },
            ),
          ),
        );
      },
    );
  }
}