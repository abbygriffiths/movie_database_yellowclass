import 'package:flutter/services.dart' show rootBundle;

String tokenizeString(String param) {
  return param.split(' ').join('+');
}

Future<String> getJsonFromRootBundle() {
  return rootBundle.loadString('secrets.json');
}
