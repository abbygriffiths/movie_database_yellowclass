import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:movie_db/models/movie_model.dart';
import 'package:movie_db/tools/movie_database_functions.dart'
    as movie_db_functions;
import 'package:movie_db/widgets/movie_dialog.dart';

class ShowMovieDetailsPage extends StatefulWidget {
  final Movie movie;

  const ShowMovieDetailsPage({Key? key, required this.movie}) : super(key: key);

  @override
  _ShowMovieDetailsPageState createState() => _ShowMovieDetailsPageState();
}

class _ShowMovieDetailsPageState extends State<ShowMovieDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text(widget.movie.title),
          actions: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                setState(() {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => MovieDialog(
                        movie: widget.movie,
                        onClickedSubmit: (title, director, imdbId) =>
                            movie_db_functions.editMovie(
                                widget.movie, title, director, imdbId),
                      ),
                    ),
                  );
                });
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Please Confirm'),
                    content: const Text(
                        'Are you sure you want to delete the movie?'),
                    actions: [
                      TextButton(
                        child: const Text('Yes'),
                        onPressed: () {
                          movie_db_functions.deleteMovie(widget.movie);
                          Navigator.of(context).pop(); // close confirm dialog
                          Navigator.of(context).pop(); // close show movie page
                        },
                      ),
                      TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('No'))
                    ],
                  ),
                );
              },
            )
          ]),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            Center(
              child: Text(
                widget.movie.title,
                maxLines: 2,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Image.network(
              widget.movie.posterUrl,
              errorBuilder: (context, error, stackTrace) =>
                  Image.asset('images/movie_poster_not_found.jpg'),
              loadingBuilder: (context, child, progress) {
                if (progress == null) {
                  return child;
                }

                return Center(
                  child: CircularProgressIndicator(
                      value: progress.expectedTotalBytes != null
                          ? progress.cumulativeBytesLoaded /
                              progress.expectedTotalBytes!
                          : null),
                );
              },
            ),
            if (widget.movie.director.isNotEmpty) ...[
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Director: ',
                    style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(widget.movie.director),
                ],
              )
            ]
          ],
        ),
      ),
    );
  }
}
