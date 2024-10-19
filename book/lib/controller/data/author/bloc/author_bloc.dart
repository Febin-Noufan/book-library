import 'package:bloc/bloc.dart';
import 'package:book/controller/data/author/bloc/author_event.dart';
import 'package:book/controller/data/author/bloc/author_state.dart';

import 'package:book/model/author.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthorBloc extends Bloc<AuthorEvent, AuthorState> {
  AuthorBloc() : super(AuthorInitial()) {
    on<FetchAuthor>((event, emit) async {
      emit(AuthorLoading());

      try {
        final response = await http.get(
          Uri.parse('https://assessment.eltglobal.in/api/authors'),
        );

        if (response.statusCode == 200) {
          final Map<String, dynamic> jsonResponse = json.decode(response.body);
          final List<dynamic> booksJson = jsonResponse['result'];

          List<Author> books =
              booksJson.map((bookJson) => Author.fromJson(bookJson)).toList();

          emit(AuthorLoaded(author: books));
        } else {
          emit(AuthorError(
              message: 'Failed to load books: ${response.reasonPhrase}'));
        }
      } catch (e) {
        emit(AuthorError(message: e.toString()));
      }
    });
  }
}
