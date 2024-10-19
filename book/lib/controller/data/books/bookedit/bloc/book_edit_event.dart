abstract class BookEditEvent {}

class DeleteBookEvent extends BookEditEvent {
  final String id;

  DeleteBookEvent({required this.id});
}

class UpdateBookEvent extends BookEditEvent {
  final String id;
  final String title;
  final String description;
  final double price;

  UpdateBookEvent({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
  });
}
