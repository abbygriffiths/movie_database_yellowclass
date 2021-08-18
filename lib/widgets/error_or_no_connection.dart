import 'package:flutter/material.dart';

class ErrorOrNoConnectionPage extends StatelessWidget {
  const ErrorOrNoConnectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('images/no_internet_or_error.png'),
        const Center(
          child: Padding(
            child: Text(
              'Could not fetch movies :/ Check your connection?',
              style: TextStyle(
                color: Colors.grey,
                fontStyle: FontStyle.italic,
              ),
            ),
            padding: EdgeInsets.all(25),
          ),
        )
      ],
    );
  }
}
