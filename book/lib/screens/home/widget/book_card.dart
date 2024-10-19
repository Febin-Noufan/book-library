import 'package:book/controller/data/authordetails/bloc/authordetails_bloc.dart';
import 'package:book/controller/data/authordetails/bloc/authordetails_event.dart';
import 'package:book/controller/data/authordetails/bloc/authordetails_state.dart';
import 'package:book/model/book.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

class BookCard extends StatelessWidget {
  final Book book;

  const BookCard({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push('/details', extra: book);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
                child: Image.network(
                  book.coverPictureURL,
                  fit: BoxFit.cover,
                  width: 106,
                  height: 160,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            book.title,
            style: const TextStyle(fontWeight: FontWeight.bold),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          BlocProvider(
           create: (context) => AuthorDetealBloc()..add(FetchAuthorDeteal(book.authorId)),
            child: BlocBuilder<AuthorDetealBloc, AuthorDetealState>(
              builder: (context, state) {
                if (state is AuthorDetealLoading) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      height: 16,
                      width: 80,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    ),
                  );
                } else if (state is AuthorDetealLoaded) {
                  return Text(
                    state.author.name,
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  );
                }
                return const Text("");
              },
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '₹${book.price}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
