extension DF on DateTime {

  String toStrCommonFormat() {
    return this.day.toString() + '-${this.month.toString()}' +
        '-${this.year.toString()}' + ' ${this.hour.toString()}'
    + ':${this.minute.toString()}' + ':${this.second.toString()}';
  }

}