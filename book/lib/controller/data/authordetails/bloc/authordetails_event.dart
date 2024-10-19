import 'package:equatable/equatable.dart';

abstract class AuthorDetealEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchAuthorDeteal extends AuthorDetealEvent {
  final String authorId;

  FetchAuthorDeteal(this.authorId);

  @override
  List<Object> get props => [authorId];
}
