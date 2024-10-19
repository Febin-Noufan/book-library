import 'package:book/model/author.dart';

abstract class AuthorAddState {}

class AuthorAddInitialState extends AuthorAddState {}

class AuthorAddLoadingState extends AuthorAddState {}

class AuthorAddSuccessState extends AuthorAddState {
  final Author author;

  AuthorAddSuccessState(this.author);
}

class AuthorAddErrorState extends AuthorAddState {
  final String error;

  AuthorAddErrorState(this.error);
}
