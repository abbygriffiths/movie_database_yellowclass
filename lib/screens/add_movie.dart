import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AddMoviePage extends StatelessWidget {
  const AddMoviePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Add Movie'),
      ),
      body: Column(
        children: [
          TextField(
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              hintText: 'Enter movie title',
            ),
            onChanged: (value) {
              // ignore: avoid_print
              print(value);
            },
          )
        ],
      ),
    );
  }
}
