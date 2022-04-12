import 'package:intl/intl.dart';

extension DF on DateTime {

  String toStrCommonFormat() {
    return this.day.toString() + '-${this.month.toString()}' +
        '-${this.year.toString()}';
  }

  String toStrSlashFormat() {
    final DateFormat formatter = DateFormat('MM/dd/yyyy');
    return formatter.format(this);
  }
}