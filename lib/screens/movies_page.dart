import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

import 'package:movie_db/models/boxes.dart';
import 'package:movie_db/models/movie_model.dart';
import 'package:movie_db/screens/show_movie_details_page.dart';
import 'package:movie_db/tools/helper_functions.dart';
import 'package:movie_db/widgets/movie_dialog.dart';

class MoviesPage extends StatefulWidget {
  const MoviesPage({Key? key}) : super(key: key);

  @override
  _MoviesPageState createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Movies Database'),
          centerTitle: true,
        ),
        body: ValueListenableBuilder<Box<Movie>>(
          valueListenable: Boxes.getMovies().listenable(),
          builder: (context, box, _) {
            final transactions = box.values.toList().cast<Movie>();
            return buildContent(transactions);
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => showDialog(
              context: context,
              builder: (context) => MovieDialog(onClickedSubmit: addMovie)),
        ),
      );

  Widget buildContent(List<Movie> movies) {
    if (movies.isEmpty) {
      return const Center(
        child: Text(
          'No movies added yet',
          style: TextStyle(fontSize: 24),
        ),
      );
    } else {
      return Column(
        children: [
          const SizedBox(height: 24),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: movies.length,
              itemBuilder: (BuildContext context, int index) {
                final movie = movies[index];
                return buildMovie(context, movie, index);
              },
            ),
          ),
        ],
      );
    }
  }

  Widget buildMovie(BuildContext context, Movie movie, int colorKey) {
    final color = Colors.primaries[colorKey % Colors.primaries.length];
    final director = movie.director;
    final imdbId = movie.imdbId;

    return Card(
      color: color,
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        title: Text(
          movie.title,
          maxLines: 2,
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
        ),
        subtitle: Text('Director: $director'),
        trailing: Text(
          'IMDB ID: $imdbId',
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white),
        ),
        children: [
          buildButtons(context, movie),
        ],
        onExpansionChanged: (expanded) => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ShowMovieDetailsPage(movie: movie),
          ),
        ),
      ),
    );
  }

  Widget buildButtons(BuildContext context, Movie movie) => Row(
        children: [
          Expanded(
            child: TextButton.icon(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MovieDialog(
                    movie: movie,
                    onClickedSubmit: (title, director, imdbId) =>
                        editMovie(movie, title, director, imdbId),
                  ),
                ),
              ),
              icon: const Icon(Icons.edit),
              label: const Text('Edit'),
            ),
          ),
          Expanded(
            child: TextButton.icon(
              icon: const Icon(Icons.delete),
              label: const Text('Delete'),
              onPressed: () => deleteMovie(movie),
            ),
          ),
        ],
      );

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
}
