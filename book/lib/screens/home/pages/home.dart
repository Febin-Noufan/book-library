import 'package:book/controller/data/books/book_bloc.dart';
import 'package:book/controller/data/books/book_event.dart';
import 'package:book/controller/data/books/book_state.dart';
import 'package:book/screens/home/widget/book_card.dart';
import 'package:book/screens/home/widget/home_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final bookBloc = BlocProvider.of<BookBloc>(context);
    bookBloc.add(FetchBooks());

    
    final TextEditingController searchController = TextEditingController();

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            const Padding(
              padding: EdgeInsets.all(14.0),
              child: Text(
                'Book Store',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.only(left: 14, right: 14),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextField(
                  controller: searchController,
                  onChanged: (query) {
                
                    bookBloc.add(SearchBooks(query: query));
                  },
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    prefixIcon: const Icon(Icons.search),
                    contentPadding: const EdgeInsets.symmetric(vertical: 5),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<BookBloc, BookState>(
                builder: (context, state) {
                  if (state is BookLoading) {
                    return GridView.builder(
                      padding: const EdgeInsets.all(14),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.65,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        return const ShimmerPlaceholder();
                      },
                    );
                  } else if (state is BookLoaded) {
                    return GridView.builder(
                      padding: const EdgeInsets.all(14),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.65,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemCount: state.books.length,
                      itemBuilder: (context, index) {
                        return BookCard(book: state.books[index]);
                      },
                    );
                  } else if (state is NoBooksFound) {
                    return Center(
                      child: Text(
                        'No books found for "${state.query}".',
                        style:
                            const TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    );
                  } else if (state is BookError) {
                    return Center(
                      child: Text(
                        'Error: ${state.message}',
                        style: const TextStyle(fontSize: 16, color: Colors.red),
                      ),
                    );
                  }

                  return const Center(
                    child:
                        CircularProgressIndicator(), 
                  );
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/bookAdd');
     
        },
        backgroundColor: Colors.black,
        child: const Icon(Icons.add),
      ),
    );
  }
}
