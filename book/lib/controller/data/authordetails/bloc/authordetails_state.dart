import 'package:book/model/author.dart';
import 'package:equatable/equatable.dart';

abstract class AuthorDetealState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthorDetealInitial extends AuthorDetealState {}

class AuthorDetealLoading extends AuthorDetealState {}

class AuthorDetealLoaded extends AuthorDetealState {
  final Author author;

  AuthorDetealLoaded(this.author);

  @override
  List<Object> get props => [author];
}

class AuthorDetealError extends AuthorDetealState {
  final String message;

  AuthorDetealError(this.message);

  @override
  List<Object> get props => [message];
}
