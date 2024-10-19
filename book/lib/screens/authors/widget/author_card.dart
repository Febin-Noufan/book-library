import 'dart:math';

import 'package:book/model/author.dart';
import 'package:flutter/material.dart';

class AuthorCard extends StatelessWidget {
  final Author author;

  const AuthorCard({
    Key? key,
    required this.author,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color randomColor = Colors
        .primaries[Random().nextInt(Colors.primaries.length)]
        .withOpacity(0.5);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        height: 70, 
        decoration: BoxDecoration(
          
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: const Color.fromARGB(255, 221, 216, 216),
            width: 1
          )
        ),
        child: ListTile(
          leading: CircleAvatar(
            radius: 22,
            backgroundColor: randomColor,
            child: Text(
              author.name.isNotEmpty ? author.name[0] : '?',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          title: Text(
            author.name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            author.biography,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}