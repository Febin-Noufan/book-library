import 'package:equatable/equatable.dart';

abstract class AddBookEvent extends Equatable {
  const AddBookEvent();

  @override
  List<Object?> get props => [];
}

class AddBookSubmitted extends AddBookEvent {
  final String title;
  final String description;
  final double price;
  final String authorId;
  final DateTime publishedDate;

  const AddBookSubmitted({
    required this.title,
    required this.description,
    required this.price,
    required this.authorId,
    required this.publishedDate,
  });

  @override
  List<Object?> get props =>
      [title, description, price, authorId, publishedDate];
}
