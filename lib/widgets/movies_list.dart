import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:movie_db/models/movie_model.dart' show Movie;
import 'package:movie_db/screens/show_movie_details.dart';

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
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ShowMovieDetailsPage(movie: movies[index]),
                  ));
            },
          ),
        );
      },
    );
  }
}
