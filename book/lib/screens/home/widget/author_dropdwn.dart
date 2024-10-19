import 'package:book/controller/data/author/bloc/author_bloc.dart';
import 'package:book/controller/data/author/bloc/author_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthorDropdown extends StatelessWidget {
  final String? selectedAuthor;
  final ValueChanged<String?> onChanged;

  const AuthorDropdown({
    required this.selectedAuthor,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthorBloc, AuthorState>(
      builder: (context, state) {
        if (state is AuthorLoading) {
          return const CircularProgressIndicator();
        } else if (state is AuthorLoaded) {
          return DropdownButtonFormField<String>(
            value: selectedAuthor,
            onChanged: onChanged,
            items: state.author.map((author) {
              return DropdownMenuItem<String>(
                value: author.id,
                child: Text(author.name), 
              );
            }).toList(),
            decoration: InputDecoration(
              labelText: 'Author',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: const BorderSide(color: Colors.blueAccent),
              ),
              filled: true,
              fillColor: Colors.grey[200],
            ),
          );
        } else if (state is AuthorError) {
          return Text("Error: ${state.message}");
        } else {
          return const Text("No Authors Available");
        }
      },
    );
  }
}
