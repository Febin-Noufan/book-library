import 'package:book/model/author.dart';

abstract class AuthorAddEvent {}

class AddAuthorEvent extends AuthorAddEvent {
  final Author author;

  AddAuthorEvent(this.author);
}
