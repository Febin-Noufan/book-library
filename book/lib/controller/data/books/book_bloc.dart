import 'package:book/controller/data/books/book_event.dart';
import 'package:book/controller/data/books/book_state.dart';
import 'package:book/model/book.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



class BookBloc extends Bloc<BookEvent, BookState> {
  List<Book> _allBooks = []; 

  BookBloc() : super(BookInitial()) {
    on<FetchBooks>((event, emit) async {
      emit(BookLoading());

      try {
        final response = await http.get(
          Uri.parse('https://assessment.eltglobal.in/api/books?page=1&limit=10'),
        );

        if (response.statusCode == 200) {
          final Map<String, dynamic> jsonResponse = json.decode(response.body);
          final List<dynamic> booksJson = jsonResponse['result'];
          
          
          _allBooks = booksJson.map((bookJson) => Book.fromJson(bookJson)).toList();

          emit(BookLoaded(books: _allBooks));
        } else {
          emit(BookError(message: 'Failed to load books: ${response.reasonPhrase}'));
        }
      } catch (e) {
        emit(BookError(message: e.toString()));
      }
    });

    on<SearchBooks>((event, emit) {
      final query = event.query.toLowerCase();
      final filteredBooks = _allBooks.where((book) => book.title.toLowerCase().contains(query)).toList();

      if (filteredBooks.isEmpty) {
        emit(NoBooksFound(query: event.query)); 
      } else {
        emit(BookLoaded(books: filteredBooks)); 
      }
    });
  }
}