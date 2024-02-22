import 'package:ebook_app/widgets/book_item.dart';
import 'package:flutter/material.dart';
import 'package:ebook_app/models/ebook.dart';

class BookList extends StatelessWidget {
  const BookList({
    Key? key,
    required this.ebooks,
    required this.onRemoveEbook,
    required this.onEditEbook,
  }) : super(key: key);

  final List<Ebook> ebooks;
  final void Function(Ebook ebook) onRemoveEbook;
  final void Function(Ebook ebook) onEditEbook;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: ebooks.length,
      itemBuilder: (ctx, index) {
        final ebook = ebooks[index];
        return GestureDetector(
          onHorizontalDragEnd: (details) {
            if (details.primaryVelocity! > 0) {
              // Swiped right, trigger editing
              onEditEbook(ebook);
            }
          },
          child: Dismissible(
            key: ValueKey(ebook),
            onDismissed: (direction) {
              if (direction == DismissDirection.endToStart) {
                // Swiped left, trigger removal
                onRemoveEbook(ebook);
              }
            },
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            secondaryBackground: Container(
              color: Colors.blue,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Icon(Icons.edit, color: Colors.white),
            ),
            child: BookItem(ebook),
          ),
        );
      },
    );
  }
}
