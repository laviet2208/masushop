import 'dart:math';

class Time {
  int second = 0;
  int minute = 0;
  int hour = 0;
  int day = 0;
  int month = 0;
  int year = 0;

  Time({
    required this.second,
    required this.minute,
    required this.hour,
    required this.day,
    required this.month,
    required this.year,
  });

  Map<dynamic, dynamic> toJson() => {
    'second': second,
    'minute': minute,
    'hour': hour,
    'day': day,
    'month': month,
    'year': year,
  };

  factory Time.fromJson(Map<dynamic, dynamic> json) {
    return Time(
      second: int.parse(json['second'].toString()),
      minute: int.parse(json['minute'].toString()),
      hour: int.parse(json['hour'].toString()),
      day: int.parse(json['day'].toString()),
      month: int.parse(json['month'].toString()),
      year: int.parse(json['year'].toString()),
    );
  }

  static Time getCurrentTime() {
    DateTime now = DateTime.now();

    Time currentTime = Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0);
    currentTime.second = now.second;
    currentTime.minute = now.minute;
    currentTime.hour = now.hour;
    currentTime.day = now.day;
    currentTime.month = now.month;
    currentTime.year = now.year;

    return currentTime;
  }

  static String generateRandomString(int n) {
    const String charset = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    Random random = Random();
    String result = "";

    for (int i = 0; i < n; i++) {
      int randomIndex = random.nextInt(charset.length);
      result += charset[randomIndex];
    }

    return result;
  }

}