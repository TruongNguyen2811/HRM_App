import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum AppDateFormat {
  yearMonthDay('yyyy-MM-dd'),
  dayMonthYear('dd/MM/yyyy'),
  hourMinute('HH:mm'),
  monthYear('MM/yyyy'),
  dayMonthYearHourMinute('dd/MM/yyyy HH:mm'),
  dayMonthLineHourMinute('dd/MM - HH:mm'),
  dayMonthSpaceHourMinute('dd/MM HH:mm'),
  dayMonth('dd/MM'),
  dayMonthYearHourMinuteSecond('dd/MM/yyyy HH:mm:ss'),
  yearMonthDayHourMinuteSecondSSS('yyyy-MM-dd HH:mm:ss'),
  dayMonthYearHourMinuteSecondMilliSecond('dd/MM/yyyy HH:mm:ss.SSS');

  const AppDateFormat(this.formatString);

  final String formatString;
}

extension DateRangeExtension on DateTimeRange {
  String toStringRange() {
    return '${start.toStringFormat(AppDateFormat.dayMonthYear)} - '
        '${end.toStringFormat(AppDateFormat.dayMonthYear)}';
  }

  bool isSeparate(DateTimeRange compareRange) {
    if (start.isBetween(compareRange) ||
        end.isBetween(compareRange) ||
        compareRange.start.isBetween(this) ||
        compareRange.end.isBetween(this)) {
      return false;
    }
    return true;
  }

  int nightCalculate() {
    final days = (end.difference(start).inHours / 24).round();
    return days == 0 ? 1 : days;
  }

  int hourCalculate() {
    final diff = end.difference(start).inMinutes;
    final h = diff ~/ 60;
    return h == 0 ? 1 : h;
  }
}

extension DateExtension on DateTime {
  String toStringFormat(AppDateFormat format, {bool toUTC = false}) {
    if (toUTC) {
      toUtc();
    }
    return DateFormat(format.formatString).format(this);
  }

  String toStringUTCFormat(AppDateFormat format) {
    return DateFormat(format.formatString).format(toUtc());
  }

  bool isPastDay() {
    final now = DateTime.now();
    return now.year > year ||
        (now.year == year && now.month > month) ||
        (now.year == year && now.month == month && now.day > day);
  }

  bool isGreaterMonthOf(DateTime date) {
    return year > date.year || (year == date.year && month > date.month);
  }

  bool isToday() {
    final now = DateTime.now();
    return now.year == year && now.month == month && now.day == day;
  }

  bool isSameDay(DateTime date) {
    return date.year == year && date.month == month && date.day == day;
  }

  bool isSameMonth(DateTime date) {
    return date.year == year && date.month == month;
  }

  DateTime change(
      {int? year,
      int? month,
      int? day,
      int? hour,
      int? minute,
      int second = 0,
      int millisecond = 0,
      int microsecond = 0}) {
    return DateTime(
        year ?? this.year,
        month ?? this.month,
        day ?? this.day,
        hour ?? this.hour,
        minute ?? this.minute,
        second,
        millisecond,
        microsecond);
  }

  DateTimeRange getDayRange({int day = 1}) {
    final start = change(hour: 0, minute: 0);
    final end =
        start.add(Duration(days: day)).subtract(const Duration(seconds: 1));
    return DateTimeRange(start: start, end: end);
  }

  DateTimeRange getMonthRange() {
    final start = change(day: 1, hour: 0, minute: 0);
    final end = start
        .add(const Duration(days: 32))
        .change(day: 1)
        .subtract(const Duration(seconds: 1));
    return DateTimeRange(start: start, end: end);
  }

  DateTimeRange getWeekRange() {
    final start =
        subtract(Duration(days: weekday - 1)).change(hour: 0, minute: 0);
    final end =
        start.add(const Duration(days: 7)).subtract(const Duration(seconds: 1));
    return DateTimeRange(start: start, end: end);
  }

  DateTimeRange getFirstWeek() {
    final weekRange = getWeekRange();
    final firstDay =
        weekRange.end.change(month: DateTime.january, day: 1, hour: 1);
    return firstDay.getWeekRange();
  }

  DateTimeRange getWeekFrom({required int weekNumber}) {
    const numberOfDayInWeek = 7;
    final startDateOfWeek = getFirstWeek()
        .start
        .add(Duration(days: (weekNumber - 1) * numberOfDayInWeek));
    return startDateOfWeek.getWeekRange();
  }

  int getWeekNumber() {
    const numberOfDayInWeek = 7;
    final startWeek = getWeekRange().start;
    final startFirstWeek = getFirstWeek().start;
    final diffDays = startWeek.difference(startFirstWeek).inDays;
    return (diffDays / numberOfDayInWeek).floor() + 1;
  }

  String getWeekBriefString() {
    switch (weekday) {
      case DateTime.monday:
        return 'T2';
      case DateTime.tuesday:
        return 'T3';
      case DateTime.wednesday:
        return 'T4';
      case DateTime.thursday:
        return 'T5';
      case DateTime.friday:
        return 'T6';
      case DateTime.saturday:
        return 'T7';
      case DateTime.sunday:
        return 'CN';
      default:
        return '';
    }
  }

  String getWeekString() {
    switch (weekday) {
      case DateTime.monday:
        return 'Thứ 2';
      case DateTime.tuesday:
        return 'Thứ 3';
      case DateTime.wednesday:
        return 'Thứ 4';
      case DateTime.thursday:
        return 'Thứ 5';
      case DateTime.friday:
        return 'Thứ 6';
      case DateTime.saturday:
        return 'Thứ 7';
      case DateTime.sunday:
        return 'Chủ nhật';
      default:
        return '';
    }
  }

  bool isWeekend() =>
      weekday == DateTime.saturday || weekday == DateTime.sunday;

  //Kiểm tra thời gian có nằm trong khoảng thời gian không
  bool isBetween(DateTimeRange range) {
    if (isAfter(range.start) && isBefore(range.end)) {
      return true;
    }
    return false;
  }

  String convertToDateVN() {
    return 'Ngày $day tháng $month năm $year';
  }
}
