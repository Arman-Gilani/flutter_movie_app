import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<List<dynamic>> fetchMovies(String query) async {
    final url = 'https://api.tvmaze.com/search/shows?q=$query';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load movies');
    }
  }
}

extension on http.Response {
  get statusCode => null;
}
