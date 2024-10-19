import 'package:flutter/material.dart';

class DatePicker extends StatelessWidget {
  final DateTime? selectedDate;
  final ValueChanged<DateTime?> onDateSelected;

  const DatePicker({
    required this.selectedDate,
    required this.onDateSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          selectedDate == null
              ? 'Select Published Date'
              : 'Date: ${selectedDate!.toLocal()}'.split(' ')[0],
          style: const TextStyle(fontSize: 16),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.lightBlue,
            elevation: 4,
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(12),
          ),
          onPressed: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
            );
            onDateSelected(pickedDate);
          },
          child: const Icon(Icons.calendar_today, color: Colors.white),
        ),
      ],
    );
  }
}