import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:movie_db/models/movie_model.dart';

class ShowMovieDetailsPage extends StatelessWidget {
  final Movie movie;

  const ShowMovieDetailsPage({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(movie.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                movie.title,
                maxLines: 2,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
            ),
            Image.network(
              movie.posterUrl,
              errorBuilder: (context, error, stackTrace) =>
                  Image.asset('images/movie_poster_not_found.jpg'),
            ),
            if (movie.director.isNotEmpty) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Director',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(movie.director),
                ],
              )
            ]
          ],
        ),
      ),
    );
  }
}
