extension DF on DateTime {

  String toStrCommonFormat() {
    return this.day.toString() + '-${this.month.toString()}' +
        '-${this.year.toString()}';
  }

}