import 'dart:convert';

import 'package:book/controller/data/authordetails/bloc/authordetails_event.dart';
import 'package:book/controller/data/authordetails/bloc/authordetails_state.dart';
import 'package:book/model/author.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class AuthorDetealBloc extends Bloc<AuthorDetealEvent, AuthorDetealState> {
  AuthorDetealBloc() : super(AuthorDetealInitial()) {
    on<FetchAuthorDeteal>((event, emit) async {
      emit(AuthorDetealLoading());
      try {
        final author = await fetchAuthor(event.authorId);
        emit(AuthorDetealLoaded(author));
      } catch (e) {
        emit(AuthorDetealError('Failed to load author: $e'));
      }
    });
  }

  Future<Author> fetchAuthor(String authorId) async {
    final response = await http.get(
        Uri.parse('https://assessment.eltglobal.in/api/authors/$authorId'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      if (jsonResponse['statusCode'] == 200) {
        final authorData = jsonResponse['result'];
        return Author.fromJson(authorData);
      } else {
        throw Exception('Failed to load author: ${jsonResponse['message']}');
      }
    } else {
      throw Exception(
          'Failed to load author with status: ${response.statusCode}');
    }
  }
}
