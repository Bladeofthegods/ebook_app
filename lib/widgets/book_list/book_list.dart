import 'package:ebook_app/widgets/book_item.dart';
import 'package:flutter/material.dart';
import 'package:ebook_app/models/ebook.dart';
import 'package:ebook_app/widgets/book_details_page.dart';

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

  //creating a function to confirm dismiss if the swipe is ltr and update if its rtl
  Future<bool> _confirmDismiss(DismissDirection direction, Ebook ebook) async {
    if (direction == DismissDirection.endToStart) {
      return true;
    } else {
      onEditEbook(ebook);
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (ebooks.isEmpty) {
      return const Center(
        child: Text("No data"),
      );
    }
    return ListView.builder(
      itemCount: ebooks.length,
      itemBuilder: (ctx, index) {
        final ebook = ebooks[index];
        return
            // GestureDetector(
            // onHorizontalDragEnd: (details) {
            //   if (details.primaryVelocity! > 0) {
            //     // Swiped right, trigger editing
            //     onEditEbook(ebook);
            //   }
            // },
            // child:

            Dismissible(
          key: ValueKey(ebook.id),
          confirmDismiss: (direction) => _confirmDismiss(direction, ebook),
          onDismissed: (direction) {
            // if (direction == DismissDirection.endToStart) {
            // Swiped left, trigger removal
            onRemoveEbook(ebook);
            // }
          },
          // direction: DismissDirection.endToStart,
          secondaryBackground: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          background: Container(
            color: Colors.blue,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: const Icon(Icons.edit, color: Colors.white),
          ),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookDetailsPage(ebook: ebook),
                ),
              );
            },
            child: BookItem(
                ebook), // Make sure your BookItem accepts the ebook object correctly
          ),
        );
      },
    );
  }
}
