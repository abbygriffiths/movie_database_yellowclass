import 'package:http/http.dart' as http;

import 'package:movie_db/models/boxes.dart';
import 'package:movie_db/models/movie_model.dart';
import 'package:movie_db/tools/helper_functions.dart';

Future addMovie(String title, String director, String imdbId) async {
  final box = Boxes.getMovies();
  final movie = await fetchMovieFromTitle(http.Client(), title);
  box.add(movie);
}

void editMovie(
    Movie movie, String newTitle, String newDirector, String newImdbId) {
  movie.title = newTitle;
  movie.director = newDirector;
  movie.imdbId = newImdbId;

  movie.save();
}

void deleteMovie(Movie movie) {
  movie.delete();
}
