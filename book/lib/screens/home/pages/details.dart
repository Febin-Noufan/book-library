import 'package:book/controller/data/authordetails/bloc/authordetails_bloc.dart';
import 'package:book/controller/data/authordetails/bloc/authordetails_event.dart';
import 'package:book/controller/data/authordetails/bloc/authordetails_state.dart';
import 'package:book/controller/data/books/bookedit/bloc/book_edit_bloc.dart';
import 'package:book/controller/data/books/bookedit/bloc/book_edit_event.dart';
import 'package:book/controller/data/books/bookedit/bloc/book_edit_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:book/model/book.dart';
import 'package:book/const.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

class BookDetailScreen extends StatelessWidget {
  final Book book;

  const BookDetailScreen({super.key, required this.book}); // Accept the book

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.black,
          onPressed: () {
            context.pop();
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Confirm Deletion'),
                    content: const Text(
                        'Are you sure you want to delete this book?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                        },
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          // Trigger the delete event
                          context
                              .read<BookEditBloc>()
                              .add(DeleteBookEvent(id: book.id));
                          Navigator.of(context).pop(); // Close the dialog
                          Navigator.of(context).pop(); // Close the dialog
                        },
                        child: const Text('Delete'),
                      ),
                    ],
                  );
                },
              );
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.edit),
            color: Colors.black,
            onPressed: () {
              _showEditBookBottomSheet(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        book.coverPictureURL, // Use the book's cover image
                        width: 171,
                        height: 260,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        book.title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      BlocProvider(
                        create: (context) => AuthorDetealBloc()
                          ..add(FetchAuthorDeteal(book.authorId)),
                        child: BlocBuilder<AuthorDetealBloc, AuthorDetealState>(
                          builder: (context, state) {
                            if (state is AuthorDetealLoading) {
                              return Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  height: 10,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                ),
                              ); // Show loading indicator
                            } else if (state is AuthorDetealError) {
                              return Text('Error: ${state.message}');
                            } else if (state is AuthorDetealLoaded) {
                              final author = state.author;
                              return Text(
                                'by ${author.name}', // Use author's name
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.grey),
                              );
                            } else {
                              return const Text('No author found');
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Published date: ${formatDate(book.publishedDate)}', // Use published date
                        style: const TextStyle(
                            fontSize: 14,
                            color: Color.fromARGB(255, 96, 95, 95)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    book.description,
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, -1), // changes position of shadow
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '₹ ${book.price}', // Use book's price
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Buy now'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showEditBookBottomSheet(BuildContext context) {
    final titleController = TextEditingController(text: book.title);
    final descriptionController = TextEditingController(text: book.description);
    final priceController = TextEditingController(text: book.price.toString());

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: const Offset(0, -1),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Book Cover Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      book.coverPictureURL,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Title Field
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      labelText: 'Title',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Description Field
                  TextField(
                    controller: descriptionController,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 8),
                  // Price Field
                  TextField(
                    controller: priceController,
                    decoration: const InputDecoration(
                      labelText: 'Price',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  BlocListener<BookEditBloc, BookEditState>(
                    listener: (context, state) {
                      if (state is BookEditError) {
                        // Show error message
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.message)),
                        );
                      } else if (state is BookDeleteSuccess) {
                        Navigator.pop(context); // Close the bottom sheet
                      }
                    },
                    child: ElevatedButton(
                      onPressed: () {
                        // Trigger the update event
                        context.read<BookEditBloc>().add(UpdateBookEvent(
                              id: book.id,
                              title: titleController.text,
                              description: descriptionController.text,
                              price: double.tryParse(priceController.text) ??
                                  book.price,
                            ));

                            context.pop();
                      },
                      child: const Text('Update Book'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
