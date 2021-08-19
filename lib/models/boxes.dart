import 'package:hive/hive.dart';

import 'package:movie_db/models/movie_model.dart';

class Boxes {
  static Box<Movie> getMovies() => Hive.box<Movie>('movies');
}
