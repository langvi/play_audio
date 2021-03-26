
String convertTimeToString(int time) {
  if (time ~/ 3600 > 1) {
    String hour = (time ~/ 3600).toString();
    String minute = ((time % 3600) ~/ 60).toString();
    String second = ((time % 3600) % 60).toString();
    if (hour.length < 2) {
      hour = '0$hour';
    } else if (minute.length < 2) {
      minute = '0$minute';
    } else if (second.length < 2) {
      second = '0$second';
    }
    return '$hour' + ':' + '$minute' + ':' + '$second';
  } else if (time ~/ 3600 < 1) {
    String minute = (time ~/ 60).toString();
    String second = (time % 60).toString();
    if (minute.length < 2) {
      minute = '0$minute';
    } else if (second.length < 2) {
      second = '0$second';
    }
    return minute + ':' + second;
  }
  return '';
}
