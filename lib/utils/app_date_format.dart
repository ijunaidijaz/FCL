import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

final df = new DateFormat('dd-MM-yyyy');
final ybefore = new DateFormat('yyyy-MM-dd');
final dmm = new DateFormat('dd-MMM-yyyy');
final dm = new DateFormat('MMM yyyy');
final time = new DateFormat('h:mma');

dateFormatYearBefore(DateTime date) {
  String newDate = ybefore.format(date).toString();
  return newDate;
}
timeFormat(DateTime date) {
  String newDate = time.format(date).toString();
  return newDate;
}
dateFormatComplete(DateTime date) {
  String newDate = dmm.format(date).toString();
  return newDate;
}

dateFormat(DateTime date) {
  String newDate = df.format(date).toString();
  return newDate;
}

dateFormatMonthName(DateTime date) {
  String newDate = dm.format(date).toString();
  return newDate;
}

//=================================Check time/date difference----------------------------------
String timeAgo(DateTime d) {
  Duration diff = DateTime.now().difference(d);
  if (diff.inDays > 365)
    return "${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? "year" : "years"} ago";
  if (diff.inDays > 30)
    return "${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? "month" : "months"} ago";
  if (diff.inDays > 7)
    return "${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? "week" : "weeks"} ago";
  if (diff.inDays > 0)
    return "${diff.inDays} ${diff.inDays == 1 ? "day" : "days"} ago";
  if (diff.inHours > 0)
    return "${diff.inHours} ${diff.inHours == 1 ? "hour" : "hours"} ago";
  if (diff.inMinutes > 0)
    return "${diff.inMinutes} ${diff.inMinutes == 1 ? "minute" : "minutes"} ago";
  return "just now";
}

String dateDifference(
    {@required DateTime startDate, @required DateTime endDate}) {
  Duration diff = endDate.difference(startDate);
  if (diff.inDays > 365)
    return "${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? "year" : "years"}";
  if (diff.inDays > 7 && diff.inDays <= 30)
    return "${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? "week" : "weeks"}";
  if (diff.inDays > 30)
    return "${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? "month" : "months"}";
  // if (diff.inDays > 0)
  //   return "${diff.inDays} ${diff.inDays == 1 ? "day" : "days"}";
  // if (diff.inHours > 0)
  //   return "${diff.inHours} ${diff.inHours == 1 ? "hour" : "hours"}";
  // if (diff.inMinutes > 0)
  //   return "${diff.inMinutes} ${diff.inMinutes == 1 ? "minute" : "minutes"}";
  return "${diff.inDays} ${diff.inDays == 1 ? "day" : "days"}";
}
