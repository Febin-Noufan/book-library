
import 'package:intl/intl.dart';



String formatDate(String dateString) {
 
  DateTime dateTime = DateTime.parse(dateString);

  return DateFormat('MMMM dd, yyyy').format(dateTime);
}