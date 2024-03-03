import 'package:flutter/material.dart';
import 'package:ebook_app/models/ebook.dart';
import 'package:ebook_app/widgets/book_details_page.dart';

class BookGridView extends StatelessWidget {
  const BookGridView({required this.ebooks, super.key});

  final List<Ebook> ebooks;

  @override
  Widget build(BuildContext context) {
    // Calculate the spacing based on the device width
    // This ensures that the total horizontal space taken by the spacings is minimal,
    // allowing the images to fit the device width.
    double spacing = 5; // Minimal even spacing between images
    double screenWidth = MediaQuery.of(context).size.width;
    double itemWidth =
        (screenWidth - spacing * 2) / 3; // Divide by 3 for 3 images per row

    return GridView.builder(
      padding: EdgeInsets.zero, // No padding around the grid
      itemCount: ebooks.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // 3 images per row
        crossAxisSpacing: spacing,
        mainAxisSpacing: spacing,
        childAspectRatio: itemWidth /
            (itemWidth * 1.5), // Adjust based on your image aspect ratio
      ),
      itemBuilder: (context, index) {
        final ebook = ebooks[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BookDetailsPage(ebook: ebook),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Hero(
                tag:
                    'book-hero-${ebook.id}', // Ensure unique tag for Hero animation
                child: Image.network(
                  ebook.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
