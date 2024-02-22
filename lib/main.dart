import 'package:ebook_app/book_home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const EbookHome(),
    ),
  );
}
