import 'package:flutter/material.dart';
import 'package:flutter_movie_app/services/api_service.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _controller = TextEditingController();
  List<dynamic> _results = [];

  void _searchMovies(String query) async {
    final response = await ApiService.fetchMovies(query);
    setState(() {
      _results = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _controller,
          decoration: InputDecoration(hintText: 'Search Movies'),
          onSubmitted: _searchMovies,
        ),
      ),
      body: ListView.builder(
        itemCount: _results.length,
        itemBuilder: (context, index) {
          final movie = _results[index]['show'];
          return ListTile(
            leading: Image.network(movie['image']['medium']),
            title: Text(movie['name']),
            subtitle: Text(movie['summary'] ?? ''),
            onTap: () {
              Navigator.pushNamed(context, '/details', arguments: movie);
            },
          );
        },
      ),
    );
  }
}
