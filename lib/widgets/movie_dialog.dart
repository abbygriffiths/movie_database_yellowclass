import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:movie_db/models/movie_model.dart';
import 'package:movie_db/tools/helper_functions.dart';

class MovieDialog extends StatefulWidget {
  final Movie? movie;
  final Function(String title, String director, String imdbId) onClickedSubmit;

  const MovieDialog({
    Key? key,
    this.movie,
    required this.onClickedSubmit,
  }) : super(key: key);

  @override
  _MovieDialogState createState() => _MovieDialogState();
}

class _MovieDialogState extends State<MovieDialog> {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final directorController = TextEditingController();
  final imdbIdController = TextEditingController();

  bool isImdb = false;

  @override
  void initState() {
    super.initState();

    if (widget.movie != null) {
      final movie = widget.movie!;

      titleController.text = movie.title;
      directorController.text = movie.director;
      imdbIdController.text = movie.imdbId;

      isImdb = movie.director.isNotEmpty;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.movie != null;
    final title = isEditing ? 'Edit Movie' : 'Add Movie';

    return AlertDialog(
      title: Text(title),
      content: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 8),
              buildTitle(),
              const SizedBox(height: 8),
              buildDirector(),
              const SizedBox(height: 8),
              buildImdbId(),
            ],
          ),
        ),
      ),
      actions: [
        buildCancelButton(context),
        buildSubmitButton(context, isEditing: isEditing),
      ],
    );
  }

  Widget buildTitle() => TextFormField(
        controller: titleController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Enter movie title',
        ),
        validator: (text) =>
            text != null && text.isEmpty ? 'Enter a title' : null,
      );

  Widget buildDirector() => TextFormField(
        controller: directorController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Enter director name',
        ),
        validator: (directorName) =>
            directorName == null ? 'Enter director' : null,
      );

  Widget buildImdbId() => TextFormField(
        controller: imdbIdController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Enter IMDB ID',
        ),
      );

  Widget buildCancelButton(BuildContext context) => TextButton(
        child: const Text('Cancel'),
        onPressed: () => Navigator.of(context).pop(),
      );

  Widget buildSubmitButton(BuildContext context, {required bool isEditing}) {
    final text = isEditing ? 'Save' : 'Add';

    return TextButton(
      child: Text(text),
      onPressed: () async {
        final isValid = formKey.currentState!.validate();

        if (isValid) {
          final title = titleController.text;
          final movie = await fetchMovieFromTitle(http.Client(), title);

          final director = directorController.text.isNotEmpty
              ? directorController.text
              : movie.director;

          final imdbId = imdbIdController.text.isNotEmpty
              ? imdbIdController.text
              : movie.imdbId;

          widget.onClickedSubmit(title, director, imdbId);

          Navigator.of(context).pop();
        }
      },
    );
  }
}
