
import 'package:flutter/material.dart';

class AuthorCardShimmer extends StatelessWidget {
  const AuthorCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor:
              Color.fromARGB(255, 96, 93, 93), 
        ),
        title: Container(
          height: 16.0,
          color: Colors.grey[300], 
        ),
        subtitle: Container(
          height: 12.0,
          color: Colors.grey[300], 
        ),
      ),
    );
  }
}
