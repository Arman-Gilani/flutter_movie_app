import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final movie = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
      appBar: AppBar(
        title: Text(movie['name'] ?? 'No Title'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            movie['image'] != null
                ? Image.network(movie['image']['original'])
                : Container(
              height: 200,
              color: Colors.grey,
              child: Icon(Icons.image_not_supported, size: 50),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                movie['name'] ?? 'No Title',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                movie['summary'] != null
                    ? movie['summary'].replaceAll(RegExp(r'<[^>]*>'), '')
                    : 'No Summary Available',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
