import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.d();

const uuid = Uuid();

class Ebook {
  Ebook({
    required this.title,
    required this.image,
    required this.author,
    required this.date,
    required this.description,
    required this.views,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final String image;
  final String author;
  final DateTime date;
  final String description;
  final int views;

  String get formattedDate {
    return formatter.format(date);
  }
}
