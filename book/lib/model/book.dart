class Book {
  final String id;
  final String title;
  final String description;
  final String publishedDate;
  final String authorId;
  final String coverPictureURL;
  final double price;

  Book({
    required this.id,
    required this.title,
    required this.description,
    required this.publishedDate,
    required this.authorId,
    required this.coverPictureURL,
    required this.price,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      publishedDate: json['publishedDate'] ?? '',
      authorId: json['authorId'] ?? '',
      coverPictureURL: json['coverPictureURL'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
    );
  }
}
