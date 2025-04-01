import 'dart:ui';

import 'package:intl/intl.dart';
import 'package:relative_time/relative_time.dart';

String formatDate(DateTime date) {
  return DateFormat.yMMMMd().format(date);
}

String formatDateRelative(DateTime date) {
  return ucFirst(
    RelativeTime.locale(
      const Locale('en'),
      timeUnits: [
        TimeUnit.hour,
        TimeUnit.day,
        TimeUnit.week,
        TimeUnit.month,
        TimeUnit.year,
      ],
    ).format(date),
  );
}

String ucFirst(String string) {
  return string.substring(0, 1).toUpperCase() + string.substring(1);
}
