import 'package:flutter/material.dart';
import 'package:ebook_app/models/ebook.dart'; // Assuming you have this model

class BookDetailsPage extends StatelessWidget {
  final Ebook ebook;

  const BookDetailsPage({Key? key, required this.ebook}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 400.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(ebook.title),
              background: Hero(
                tag: 'book-hero-${ebook.id}',
                child: Image.network(
                  ebook.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: Colors.white.withOpacity(
                  0.8), // Semi-transparent fill color for the description
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Text(
                    ebook.title,
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black.withOpacity(0.5)),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'By ${ebook.author}',
                    style: TextStyle(
                        fontSize: 18, color: Colors.black.withOpacity(0.5)),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Published on: ${ebook.date.toString()}',
                    style: TextStyle(
                        fontSize: 16, color: Colors.black.withOpacity(0.5)),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      ebook.description,
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
