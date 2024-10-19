import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const Color lightPrimaryColor = Color(0xFFFFFFFF); 
const Color lightSecondaryColor = Color(0xFFF1F1F1); // Light Grey
const Color lightAccentColor = Color(0xFF6200EE); // Purple Accent
const Color lightBackgroundColor = Color(0xFFF5F5F5); // Very Light Grey
const Color lightTextColor = Color(0xFF000000); // Black
const Color lightIconColor = Color(0xFF6200EE); // Purple Accent



const Color darkPrimaryColor = Color.fromARGB(255, 11, 11, 11); 
const Color darkSecondaryColor = Color.fromARGB(255, 48, 47, 47); // Light Grey
const Color darkAccentColor = Color(0xFF6200EE); // Purple Accent
const Color darkBackgroundColor = Color.fromARGB(255, 9, 9, 9); // Very Light Grey
const Color darkTextColor = Color.fromARGB(255, 248, 247, 247); // Black
const Color datkIconColor = Color(0xFF6200EE); // Purple Accent




String formatDate(String dateString) {
  // Parse the original date string
  DateTime dateTime = DateTime.parse(dateString);
  // Format the date
  return DateFormat('MMMM dd, yyyy').format(dateTime);
}