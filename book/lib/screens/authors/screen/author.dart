import 'package:book/controller/data/author/bloc/author_bloc.dart';
import 'package:book/controller/data/author/bloc/author_event.dart';
import 'package:book/controller/data/author/bloc/author_state.dart';
import 'package:book/screens/authors/widget/author_card.dart';
import 'package:book/screens/authors/widget/author_shimme.dart';
import 'package:book/screens/authors/widget/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class AuthorsPage extends StatelessWidget {
  const AuthorsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AuthorBloc>(context).add(FetchAuthor());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Authors', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
      ),
      body: BlocBuilder<AuthorBloc, AuthorState>(
        builder: (context, state) {
          if (state is AuthorLoading) {
            return _buildShimmerEffect();
          } else if (state is AuthorLoaded) {
            if (state.author.isEmpty) {
              return const Center(child: Text("No Authors Available"));
            }
            return ListView.builder(
              itemCount: state.author.length,
              itemBuilder: (context, index) {
                return AuthorCard(author: state.author[index]);
              },
            );
          } else if (state is AuthorError) {
            return Center(child: Text("Error: ${state.message}"));
          }
          return const Center(child: Text("No Authors"));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            builder: (context) =>  const AddAuthorBottomSheet(),
          );
        },
        backgroundColor: Colors.black,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildShimmerEffect() {
    return ListView.builder(
      itemCount: 7, 
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: const AuthorCardShimmer(),
        );
      },
    );
  }
}


