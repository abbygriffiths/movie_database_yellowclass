import 'package:flutter/material.dart';

import 'screens/list_movies.dart';

void main() {
  runApp(const MovieDatabaseApp());
}

class MovieDatabaseApp extends StatelessWidget {
  const MovieDatabaseApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Database',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ListMoviesPage(
        title: 'Movies Database',
      ),
    );
  }
}
