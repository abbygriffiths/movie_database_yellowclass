import 'package:flutter/material.dart';

import 'package:movie_db/models/movie.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Movie movie;

  _HomePageState() {
    movie = Movie(title: 'Interstellar');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            'Movie Database',
            style: TextStyle(
                color: Colors.black87, fontFamily: 'Overpass', fontSize: 20),
          )),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Text(movie.title),
          Text(movie.director),
          Container(child: movie.poster)
        ],
      ),
    );
  }
}
