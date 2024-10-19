import 'package:book/controller/data/author/authoradd/authoradd_event.dart';
import 'package:book/controller/data/author/authoradd/authoradd_state.dart';
import 'package:book/model/author.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthorAddBloc extends Bloc<AuthorAddEvent, AuthorAddState> {
  AuthorAddBloc() : super(AuthorAddInitialState()) {
    on<AddAuthorEvent>(_onAddAuthor);
  }

  Future<void> _onAddAuthor(
    AddAuthorEvent event,
    Emitter<AuthorAddState> emit,
  ) async {
    emit(AuthorAddLoadingState());
    try {
      final response = await http.post(
        Uri.parse('https://assessment.eltglobal.in/api/authors'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(event.author.toJson()),
      );

      if (response.statusCode == 201) {
        final jsonResponse = json.decode(response.body);
        final author = Author.fromJson(jsonResponse['result']);
        emit(AuthorAddSuccessState(author));
      } else {
        emit(AuthorAddErrorState('Failed to add author'));
      }
    } catch (e) {
      emit(AuthorAddErrorState('Error: ${e.toString()}'));
    }
  }
}
