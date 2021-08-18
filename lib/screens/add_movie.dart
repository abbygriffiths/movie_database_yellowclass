import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:movie_db/models/movie.dart' show Movie;

class AddMoviePage extends StatefulWidget {
  const AddMoviePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AddMoviePageState();
}

Movie parseMovieFromTitle(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return Movie.fromJson(parsed);
}

// Future<Movie> getMovieFromTitle(String title) async {
//   String apiUrl = await getApiUrl();
// }

class _AddMoviePageState extends State<AddMoviePage> {
  String _value = '';

  @override
  Widget build(BuildContext context) {
    void searchForMovie() {}

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Add Movie'),
      ),
      body: Column(
        children: [
          Center(
            child: TextField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                hintText: 'Enter movie title',
              ),
              onChanged: (value) {
                _value = value;
              },
            ),
          ),
          OutlinedButton(
            onPressed: () {
              searchForMovie();
            },
            child: const Text('Search by title'),
          )
        ],
      ),
    );
  }
}
