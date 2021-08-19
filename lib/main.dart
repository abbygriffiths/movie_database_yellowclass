import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:movie_db/models/movie_model.dart';
import 'package:movie_db/provider/google_sign_in.dart';
import 'package:movie_db/screens/home_page.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await Hive.initFlutter();

  Hive.registerAdapter(MovieAdapter());
  await Hive.openBox<Movie>('movies');

  runApp(const MovieDatabaseApp());
}

class MovieDatabaseApp extends StatelessWidget {
  const MovieDatabaseApp({Key? key}) : super(key: key);
  static const String title = 'Movies Database';

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => GoogleSignInProvider(),
        child: MaterialApp(
          title: title,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.yellow,
          ),
          home: const HomePage(),
        ),
      );
}
