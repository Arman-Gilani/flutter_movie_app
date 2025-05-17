import 'package:flutter/material.dart';
import 'package:flutter_movie_app/services/api_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<dynamic>> movies;

  @override
  void initState() {
    super.initState();
    movies = ApiService.fetchMovies('all'); // Fetch all movies
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: FutureBuilder(
        future: movies,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final moviesList = snapshot.data as List<dynamic>;
            return ListView.builder(
              itemCount: moviesList.length,
              itemBuilder: (context, index) {
                final movie = moviesList[index]['show'];
                return ListTile(
                  leading: movie['image'] != null
                      ? Image.network(movie['image']['medium'])
                      : Container(
                    width: 50,
                    height: 50,
                    color: Colors.grey,
                    child: Icon(Icons.image_not_supported),
                  ),
                  title: Text(movie['name'] ?? 'No Title'),
                  subtitle: Text(
                    movie['summary'] != null
                        ? movie['summary'].replaceAll(RegExp(r'<[^>]*>'), '')
                        : 'No Summary Available',
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/details', arguments: movie);
                  },
                );
              },
            );
          }
        },
      ),

      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
        ],
        onTap: (index) {
          if (index == 1) {
            Navigator.pushNamed(context, '/search');
          }
        },
      ),


    );
  }
}
