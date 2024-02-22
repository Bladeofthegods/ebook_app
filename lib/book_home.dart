import 'package:ebook_app/widgets/book_list/book_list.dart';
import 'package:ebook_app/widgets/book_list/new_book.dart';
import 'package:flutter/material.dart';
import 'package:ebook_app/models/ebook.dart';

class EbookHome extends StatefulWidget {
  const EbookHome({super.key});

  @override
  State<EbookHome> createState() => _EbookHomeState();
}

class _EbookHomeState extends State<EbookHome> {
  final List<Ebook> _registeredEbook = [
    Ebook(
      title: 'Flutter Course',
      image: 'https://zerobooks.co/a.a.a/images/id12.jpg',
      date: DateTime.now(),
      author: 'Madman',
      description:
          'When Mary needs to pick a topic for her research project, she lands on investigating the rumor about the “Magic Mirror of Hallucinations,” a nightmarish object said to cause your own reflection to try to switch places with you. Naturally, Mary immediately stumbles upon the mirror and carelessly exposes herself to its effects—when nothing happens, she wonders whether it was just a rumor after all. Soon enough, however, it appears to her friends and classmates that she’s turned over a new leaf: where before she went to such great lengths to be demure and ladylike, she’s now wearing frilly miniskirts, referring to herself as “Platinum Heart SR,” and, most troublingly, claiming she’s neck-deep in a conflict with a shadowy cabal known only as “the organization.” Can Mary successfully unravel the organization’s intrigue before her academy life collapses? Or will she go down in the hearts and minds of her friends as the girl who failed to defeat the great evil haunting her?',
      views: 20,
    ),
    Ebook(
      title: 'That time',
      image: 'https://zerobooks.co/a.a.a/images/id12.jpg',
      date: DateTime.now(),
      author: 'Mgt',
      description:
          'When Mary needs to pick a topic for her research project, she lands on investigating the rumor about the “Magic Mirror of Hallucinations,” a nightmarish object said to cause your own reflection to try to switch places with you. Naturally, Mary immediately stumbles upon the mirror and carelessly exposes herself to its effects—when nothing happens, she wonders whether it was just a rumor after all. Soon enough, however, it appears to her friends and classmates that she’s turned over a new leaf: where before she went to such great lengths to be demure and ladylike, she’s now wearing frilly miniskirts, referring to herself as “Platinum Heart SR,” and, most troublingly, claiming she’s neck-deep in a conflict with a shadowy cabal known only as “the organization.” Can Mary successfully unravel the organization’s intrigue before her academy life collapses? Or will she go down in the hearts and minds of her friends as the girl who failed to defeat the great evil haunting her?',
      views: 20,
    ),
  ];

  void _openAddNewBookOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      // scrollControlDisabledMaxHeightRatio: 1,
      // constraints:
      //     BoxConstraints(maxHeight: MediaQuery.of(context).size.height / 1),
      context: context,
      builder: (ctx) => NewBook(onAddNewBook: _addNewBook),
    );
  }

  void _addNewBook(Ebook ebook) {
    setState(
      () {
        _registeredEbook.add(ebook);
      },
    );
  }

  void _removeBook(Ebook ebook) {
    setState(
      () {
        _registeredEbook.remove(ebook);
      },
    );
  }

  void _editBook(Ebook ebook) {
    // Find the index of the ebook to be edited
    int ebookIndex = _registeredEbook.indexWhere((e) => e == ebook);

    // Show a modal bottom sheet to allow users to edit the ebook's details
    showModalBottomSheet(
      isScrollControlled: true,
      context: context, // Pass the context here
      builder: (ctx) {
        return NewBook(
          // Pass a function to handle saving the edited ebook
          onAddNewBook: (editedEbook) {
            // Update the ebook in the list
            setState(() {
              _registeredEbook[ebookIndex] = editedEbook;
            });
            Navigator.of(context).pop(); // Close the modal bottom sheet
          },
          // Pass the ebook to be edited to the NewBook widget
          initialEbook: ebook,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: _openAddNewBookOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
        title: const Text('ZEROBOOKS'),
      ),
      body: Column(
        children: [
          const Text('The chart'),
          Expanded(
            child: BookList(
              ebooks: _registeredEbook,
              onRemoveEbook: _removeBook,
              onEditEbook: _editBook,
            ),
          )
        ],
      ),
    );
  }
}
