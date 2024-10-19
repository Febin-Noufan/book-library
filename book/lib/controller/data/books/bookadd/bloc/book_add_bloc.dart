import 'package:book/controller/data/books/bookadd/bloc/book_add_event.dart';
import 'package:book/controller/data/books/bookadd/bloc/book_add_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AddBookBloc extends Bloc<AddBookEvent, AddBookState> {
  AddBookBloc() : super(AddBookInitial()) {
   
    on<AddBookSubmitted>((event, emit) async {
      emit(AddBookLoading());
      try {
        await addBook(
          title: event.title,
          description: event.description,
          price: event.price,
          authorId: event.authorId,
          publishedDate: event.publishedDate,
        );
        emit(AddBookSuccess());
      } catch (e) {
        emit(AddBookError(message: e.toString()));
      }
    });
  }


  Future<void> addBook({
    required String title,
    required String description,
    required double price,
    required String authorId,
    required DateTime publishedDate,
  }) async {
    final response = await http.post(
      Uri.parse('https://assessment.eltglobal.in/api/books'),
      headers: {
        'accept': '*/*',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'title': title,
        'description': description,
        'price': price,
        'authorId': authorId,
        'publishedDate': publishedDate.toIso8601String(),
      }),
    );
    print("........................${response.body}");

    if (response.statusCode != 201) {
      throw Exception('Failed to add book: ${response.body}');
    }
  }
}
