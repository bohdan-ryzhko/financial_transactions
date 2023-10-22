import 'package:intl/intl.dart';

String getNormalizeDate(String? dateTimeString) {
  if (dateTimeString == null) return "";

  final dateTime = DateTime.parse(dateTimeString);
  return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}';
}

String getLocalizationDate(String? date) {
  if (date == null) return "";

  final transactionDate = DateTime.parse(date);
  final localTransactionDate = transactionDate.toLocal();

  final dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
  final formattedDate = dateFormat.format(localTransactionDate);

  return getNormalizeDate(formattedDate);
}
