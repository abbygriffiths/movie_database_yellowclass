// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';

import 'package:hive/hive.dart';
import 'package:flutter/material.dart';

const String apiEndpoint = 'http://www.omdbapi.com/?apikey=';

@HiveType(typeId: 1)
class Movie {
  Movie({required this.title}) {
    getDetailsFromAPI();
  }

  @HiveField(0)
  final String title;

  @HiveField(1)
  String director = '';

  @HiveField(2)
  Image? poster;

  @override
  String toString() {
    return '$title by $director';
  }

  void getDetailsFromAPI() async {
    final String queryUrl = apiEndpoint + '&t=$title';
    var url = Uri.parse(queryUrl);
    var response = await http.get(url);

    Map<String, dynamic> responseJson = jsonDecode(response.body);
    director = responseJson['Director'];
    poster = Image.network(responseJson['Poster']);
  }
}

void main() async {
  var path = Directory.current.path;
  Hive.init(path);

  Movie interstellar = Movie(title: 'Interstellar');

  var movieBox = await Hive.openBox('moviesBox');
  movieBox.put(interstellar.title, interstellar);

  print(movieBox.get('Interstellar'));
}
