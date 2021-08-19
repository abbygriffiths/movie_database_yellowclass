import 'package:hive/hive.dart';

import 'package:movie_db/models/movie_search_result.dart';

part 'movie_model.g.dart';

@HiveType(typeId: 0)
class Movie extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String posterUrl;

  @HiveField(2)
  String imdbId;

  @HiveField(3)
  String director = '';

  Movie({
    required this.title,
    required this.posterUrl,
    required this.imdbId,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    final movie = Movie(
      title: json['Title'] as String,
      posterUrl: json['Poster'] as String,
      imdbId: json['imdbID'] as String,
    );
    if (json.containsKey('Director')) {
      movie.director = json['Director'];
    }
    return movie;
  }

  factory Movie.fromSearchResult(MovieSearchResult result) {
    return Movie(
      title: result.title,
      posterUrl: result.posterUrl,
      imdbId: result.imdbId,
    );
  }

  @override
  String toString() {
    return '$title (IMDB: $imdbId)';
  }
}
