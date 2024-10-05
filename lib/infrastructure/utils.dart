import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void printLn(Object? object) {
  if (kDebugMode) {
    print(object);
  }
}

class DateUtil {

  static showTimeRange(TimeOfDay from, TimeOfDay to) {
    return '${from.hour} : ${from.minute} ${from.period.name.toUpperCase()} to ${to.hour} : ${to.minute} ${to.period.name.toUpperCase()}';
  }

  static showTimeSelected(TimeOfDay time) {
    return '${time.hour.toString()}:${time.minute.toString()} ${time.period.name.toString().toUpperCase()}';
  }

  static displayDiffrence(final DateTime from, final DateTime to) {
    return " x ${from.day - to.day} Days";
  }

  static displayTimeRange({required TimeOfDay from, required TimeOfDay to}) {
    return "${from.hour}:${from.minute} ${from.period.name} to ${to.hour}:${to.minute} ${to.period.name}";
  }

  static bool isSameDate(DateTime from, DateTime to) {
    return from.day == to.day && _isSameMonthYear(from, to);
  }

  static bool isSametoday(DateTime date) {
    return date.day == DateTime.now().toUtc().day &&
        _isSameMonthYear(date, DateTime.now().toUtc());
  }

  static _labeledDay(String day) {
    if (day.endsWith('1')) return '${day}st';
    if (day.endsWith('2')) return '${day}nd';
    if (day.endsWith('3')) return '${day}rd';
    return '${day}th';
  }

  



  static bool _isSameMonthYear(DateTime from, DateTime to) {
    return from.month == to.month && _isSameYear(from, to);
  }

  static bool _isSameYear(DateTime from, DateTime to) {
    return from.year == to.year;
  }
}

class Validate {
  static String? validateEmail(String? value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);

    if (value!.isEmpty) {
      return 'Enter an email address';
    } else if (value.isNotEmpty && !regex.hasMatch(value)) {
      return 'Enter a valid email address';
    } else {
      return null;
    }
  }

  static String? validatePassword(String? value) {
    RegExp regex = RegExp(
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~_%]).{8,}$');
    if (value!.isEmpty || value.length < 8) {
      return 'Please enter valid password';
    } else {
      if (!regex.hasMatch(value)) {
        return '';
      } else {
        return null;
      }
    }
  }
}


class EnumUtil {
  static T strToEnum<T extends Enum>(List<T> values, String str) {
    return values.firstWhere((element) => str.toLowerCase() == element.name);
  }

  static T? strToEnumNullable<T extends Enum>(List<T> values, String? str) {
    return str != null ? strToEnum(values, str) : null;
  }
}

class NameUtil {
  static String getInitials(final String? name, final String? surname) {
    return ((name?.substring(0, 1) ?? '') + (surname?.substring(0, 1) ?? ''))
        .toUpperCase();
  }

  static String getLastName({required String fullName}) {
    return fullName.split(" ").last;
  }

  static String getFirstName({required String fullName}) {
    return fullName.split(" ").first;
  }

  static String getFullName(final String? name, final String? surname) {
    return "$name $surname";
  }
}

Widget? modelToWidget<T>(T? model, Widget Function(T) mapper) {
  return model != null ? mapper.call(model) : null;
}

class NumberUtil {
  static T getLower<T extends num>(T num1, T num2) {
    return num1 <= num2 ? num1 : num2;
  }

  static String padNumber(num num, {String? left = '0', int length = 0}) {
    if (num == 0) return '0';
    final String strNum = num.toString();
    if (length == 0 || length < strNum.length) return strNum;
    String padded = '';
    for (int i = 0; i < length - strNum.length; i++) {
      padded += left!;
    }
    return padded + strNum;
  }

  static String numberFormat(int n) {
    String num = n.toString();
    int len = num.length;

    if (n >= 1000 && n < 1000000) {
      return '${num.substring(0, len - 3)}.${num.substring(len - 3, 1 + (len - 3))}k';
    } else if (n >= 1000000 && n < 1000000000) {
      return '${num.substring(0, len - 6)}.${num.substring(len - 6, 1 + (len - 6))}M';
    } else if (n > 1000000000) {
      return '${num.substring(0, len - 9)}.${num.substring(len - 9, 1 + (len - 9))}B';
    } else {
      return num.toString();
    }
  }
}
