import 'package:book/model/author.dart';

abstract class AuthorState {}

class AuthorInitial extends AuthorState {}

class AuthorLoading extends AuthorState {}

class AuthorLoaded extends AuthorState {
  final List<Author> author;

  AuthorLoaded({required this.author});
}

class AuthorError extends AuthorState {
  final String message;

  AuthorError({required this.message});
}
