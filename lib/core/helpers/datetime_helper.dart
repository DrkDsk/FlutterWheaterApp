class DateTimeTimeHelper {

  static bool isNight(DateTime now, int sunrise, int sunset) {
    return now.isBefore(DateTime.fromMillisecondsSinceEpoch(sunrise * 1000)) ||
        now.isAfter(DateTime.fromMillisecondsSinceEpoch(sunset * 1000));
  }
}