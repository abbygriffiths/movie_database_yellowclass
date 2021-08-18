import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class Movie {
  @HiveField(0)
  final String title;

  @HiveField(2)
  final String posterUrl;

  const Movie({required this.title, required this.posterUrl});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['Title'] as String,
      posterUrl: json['Poster'] as String,
    );
  }

  @override
  String toString() {
    return title;
  }
}
