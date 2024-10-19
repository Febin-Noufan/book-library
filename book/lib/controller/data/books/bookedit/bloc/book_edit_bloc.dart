import 'dart:convert';
import 'package:book/model/book.dart';
import 'package:http/http.dart' as http;
import 'package:book/controller/data/books/bookedit/bloc/book_edit_event.dart';
import 'package:book/controller/data/books/bookedit/bloc/book_edit_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookEditBloc extends Bloc<BookEditEvent, BookEditState> {
  BookEditBloc() : super(BookEditInitial()) {
    on<DeleteBookEvent>(_onDeleteBookEvent);
    on<UpdateBookEvent>(_onUpdateBookEvent);
  }


  Future<void> _onDeleteBookEvent(
      DeleteBookEvent event, Emitter<BookEditState> emit) async {
    emit(BookEditLoading());
    try {
      final response = await http.delete(
        Uri.parse('https://assessment.eltglobal.in/api/books/${event.id}'),
        headers: {
          'accept': '*/*',
        },
      );

      if (response.statusCode == 200) {
        emit(BookDeleteSuccess());
      } else {
        emit(BookEditError(
            message: "Failed to delete book: ${response.reasonPhrase}"));
      }
    } catch (error) {
      emit(BookEditError(message: "Failed to delete book: $error"));
    }
  }


  Future<void> _onUpdateBookEvent(
      UpdateBookEvent event, Emitter<BookEditState> emit) async {
    emit(BookEditLoading());
    try {
      final response = await http.patch(
        Uri.parse('https://assessment.eltglobal.in/api/books/${event.id}'),
        headers: {
          'Content-Type': 'application/json',
          'accept': '*/*',
        },
        body: jsonEncode({
          'title': event.title,
          'description': event.description,
          'price': event.price,
        }),
      );

      if (response.statusCode == 200) {
   
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final Book updatedBook = Book.fromJson(responseData['result']);

        emit(BookEditSuccess(updatedBook: updatedBook)); 
      } else {
        emit(BookEditError(
            message: "Failed to update book: ${response.reasonPhrase}"));
      }
    } catch (error) {
      emit(BookEditError(message: "Failed to update book: $error"));
    }
  }
}
