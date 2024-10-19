import 'package:book/model/book.dart';

abstract class BookEditState {}

class BookEditInitial extends BookEditState {}

class BookEditLoading extends BookEditState {}
class BookEditSuccess extends BookEditState {
  final Book updatedBook;

  BookEditSuccess({required this.updatedBook});
}



class BookDeleteSuccess extends BookEditState {}

class BookEditError extends BookEditState {
  final String message;

  BookEditError({required this.message});
}