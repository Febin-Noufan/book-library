import 'package:book/controller/data/author/bloc/author_bloc.dart';
import 'package:book/controller/data/author/bloc/author_event.dart';

import 'package:book/controller/data/books/bookadd/bloc/book_add_bloc.dart';
import 'package:book/controller/data/books/bookadd/bloc/book_add_event.dart';
import 'package:book/controller/data/books/bookadd/bloc/book_add_state.dart';
import 'package:book/screens/home/widget/author_dropdwn.dart';
import 'package:book/screens/home/widget/costom_textfield.dart';
import 'package:book/screens/home/widget/date_picker.dart';
import 'package:book/screens/home/widget/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class AddBookPage extends StatelessWidget {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  DateTime? _selectedDate;
  String? _selectedAuthor;

  AddBookPage({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AuthorBloc>(context).add(FetchAuthor());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Book'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 4.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocListener<AddBookBloc, AddBookState>(
          listener: (context, state) {
            if (state is AddBookSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Book added successfully')),
              );
              Navigator.pop(context); // Optionally navigate back
            } else if (state is AddBookError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error: ${state.message}')),
              );
            }
          },
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Text(
                  'Enter Book Details',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 30),
                CustomTextField(
                  controller: _titleController,
                  labelText: 'Title',
                  icon: Icons.title,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: _descriptionController,
                  labelText: 'Description',
                  icon: Icons.description,
                  maxLines: 3,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: _priceController,
                  labelText: 'Price',
                  icon: Icons.attach_money,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 30),
                AuthorDropdown(
                  selectedAuthor: _selectedAuthor,
                  onChanged: (value) {
                    _selectedAuthor = value;
                  },
                ),
                const SizedBox(height: 20),
                DatePicker(
                  selectedDate: _selectedDate,
                  onDateSelected: (pickedDate) {
                    _selectedDate = pickedDate;
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Date selected')),
                    );
                  },
                ),
                const SizedBox(height: 50),
                SubmitButton(
                  onPressed: () {
                    if (_titleController.text.isNotEmpty &&
                        _descriptionController.text.isNotEmpty &&
                        _priceController.text.isNotEmpty &&
                        _selectedDate != null &&
                        _selectedAuthor != null) {
                      BlocProvider.of<AddBookBloc>(context).add(
                        AddBookSubmitted(
                          authorId: _selectedAuthor!,
                          title: _titleController.text,
                          description: _descriptionController.text,
                          price: double.parse(_priceController.text),
                          publishedDate: _selectedDate!,
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please fill all fields')),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
