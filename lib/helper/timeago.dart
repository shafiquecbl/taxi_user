class TimeAgo {
  static String timeAgoSinceDate(DateTime dateString,
      {bool numericDates = true}) {
    DateTime notificationDate = dateString;
    final difference = DateTime.now().difference(notificationDate);

    if (difference.inDays > 30) {
      return dateString.toString().split('T').first;
    } else if (difference.inDays > 28) {
      return (numericDates) ? '4w ago' : '4w ago';
    } else if (difference.inDays > 21) {
      return (numericDates) ? '3w ago' : '3w ago';
    } else if (difference.inDays > 14) {
      return (numericDates) ? '2w ago' : '2w ago';
    } else if ((difference.inDays / 7).floor() >= 1) {
      return (numericDates) ? '1w ago' : '1w ago';
    } else if (difference.inDays >= 2) {
      return '${difference.inDays}d ago';
    } else if (difference.inDays >= 1) {
      return (numericDates) ? '1d ago' : '1d ago';
    } else if (difference.inHours >= 2) {
      return '${difference.inHours}h ago';
    } else if (difference.inHours >= 1) {
      return (numericDates) ? '1d ago' : '1d ago';
    } else if (difference.inMinutes >= 2) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inMinutes >= 1) {
      return (numericDates) ? '1m ago' : '1m ago';
    } else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds}s ago';
    } else {
      return 'Just now';
    }
  }
}

int getAge(String value) {
  List<String> list = value.split('-');
  var date =
      DateTime(int.parse(list.last), int.parse(list[1]), int.parse(list.first));
  var now = DateTime.now();
  var difference = now.difference(date);
  return (difference.inDays / 365).floor();
}

String getTime(DateTime dateTime) {
  String hour = dateTime.hour.toString();
  String minute = dateTime.minute.toString();
  String ampm = 'AM';
  if (dateTime.hour > 12) {
    hour = (dateTime.hour - 12).toString();
    ampm = 'PM';
  }
  if (dateTime.minute < 10) {
    minute = '0$minute';
  }
  return '$hour:$minute $ampm';
}
