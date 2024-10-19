abstract class BookEvent {}

class FetchBooks extends BookEvent {}

class SearchBooks extends BookEvent {
  final String query;

  SearchBooks({required this.query});
}
