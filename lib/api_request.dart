import 'dart:convert';

import 'package:http/http.dart' as http;

Future<List<dynamic>> fetchPhotos() async {
  final response =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load photos');
  }
}
