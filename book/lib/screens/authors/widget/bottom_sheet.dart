import 'package:book/controller/data/author/authoradd/authoradd_bloc.dart';
import 'package:book/controller/data/author/authoradd/authoradd_event.dart';
import 'package:book/controller/data/author/authoradd/authoradd_state.dart';
import 'package:book/model/author.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class AddAuthorBottomSheet extends StatefulWidget {
  const AddAuthorBottomSheet({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AddAuthorBottomSheetState createState() => _AddAuthorBottomSheetState();
}

class _AddAuthorBottomSheetState extends State<AddAuthorBottomSheet> {
  final uuid = const Uuid();
  DateTime? selectedDate;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _biographyController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  void _addAuthor(BuildContext context) {
    if (_nameController.text.isNotEmpty &&
        _biographyController.text.isNotEmpty &&
        selectedDate != null) {
      final author = Author(
        id: uuid.v4(),
        name: _nameController.text,
        birthdate: selectedDate!,
        biography: _biographyController.text,
      );
      BlocProvider.of<AuthorAddBloc>(context).add(AddAuthorEvent(author));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthorAddBloc, AuthorAddState>(
      listener: (context, state) {
        if (state is AuthorAddSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Author added successfully')),
          );
          Navigator.pop(context); // Close the bottom sheet
        } else if (state is AuthorAddErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Add author',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _biographyController,
                maxLines: 15,
                decoration: InputDecoration(
                  labelText: 'Biography',
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                readOnly: true,
                onTap: () => _selectDate(context),
                decoration: InputDecoration(
                  labelText: 'DOB',
                  hintText: selectedDate == null
                      ? 'Select a date'
                      : '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
                  suffixIcon: const Icon(Icons.calendar_today),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () => _addAuthor(context),
                  child: const Text(
                    'Add author',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        );
      },
    );
  }
}
