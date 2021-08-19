import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_db/screens/movies_page.dart';
import 'package:movie_db/widgets/sign_up_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              return const MoviesPage();
            } else if (snapshot.hasError) {
              return const Center(child: Text('Something went wrong :/'));
            } else {
              return const SignUpWidget();
            }
          },
        ),
      );
}
