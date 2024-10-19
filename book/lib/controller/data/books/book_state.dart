import 'package:book/model/book.dart';

abstract class BookState {}

class BookInitial extends BookState {}

class BookLoading extends BookState {}

class BookLoaded extends BookState {
  final List<Book> books;

  BookLoaded({required this.books});
}

class BookError extends BookState {
  final String message;

  BookError({required this.message});
}

class NoBooksFound extends BookState {
  final String query;

  NoBooksFound({required this.query});
}
