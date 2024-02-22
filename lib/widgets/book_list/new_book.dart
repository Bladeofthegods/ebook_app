import 'package:flutter/material.dart';
import 'package:ebook_app/models/ebook.dart';

class NewBook extends StatefulWidget {
  const NewBook({
    Key? key,
    required this.onAddNewBook,
    this.initialEbook,
  }) : super(key: key);

  final void Function(Ebook ebook) onAddNewBook;
  final Ebook? initialEbook; // Define initialEbook parameter

  @override
  State<NewBook> createState() {
    return _NewBook();
  }
}

class _NewBook extends State<NewBook> {
  final _titleController = TextEditingController();
  final _authorController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _imageController = TextEditingController();
  final _viewsController = TextEditingController();
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();

    // Initialize text controllers with initial ebook data
    if (widget.initialEbook != null) {
      final initialEbook = widget.initialEbook!;
      _titleController.text = initialEbook.title;
      _authorController.text = initialEbook.author;
      _descriptionController.text = initialEbook.description;
      _imageController.text = initialEbook.image;
      _viewsController.text = initialEbook.views.toString();
      _selectedDate = initialEbook.date;
    }
  }

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _saveBook() {
    final enteredViews = int.tryParse(_viewsController.text) ?? 0;

    widget.onAddNewBook(
      Ebook(
        title: _titleController.text,
        image: _imageController.text,
        author: _authorController.text,
        date: _selectedDate!,
        description: _descriptionController.text,
        views: enteredViews,
      ),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    _descriptionController.dispose();
    _imageController.dispose();
    _viewsController.dispose();
    super.dispose();
  }

  @override
  Widget build(ctx) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(label: Text('Title')),
          ),
          TextField(
            controller: _authorController,
            maxLength: 50,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(label: Text('Author')),
          ),
          TextField(
            controller: _descriptionController,
            maxLength: 1000,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(label: Text('Description')),
          ),
          TextField(
            controller: _imageController,
            maxLength: 500,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(label: Text('Image')),
          ),
          TextField(
            controller: _viewsController,
            maxLength: 50,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(label: Text('Views')),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(_selectedDate == null
                  ? 'No date Selected'
                  : formatter.format(_selectedDate!)),
              IconButton(
                  onPressed: _presentDatePicker,
                  icon: const Icon(Icons.calendar_month))
            ],
          ),
          Row(
            children: [
              ElevatedButton(
                  onPressed: _saveBook, child: const Text('Save Book')),
              const Spacer(),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'))
            ],
          )
        ],
      ),
    );
  }
}
