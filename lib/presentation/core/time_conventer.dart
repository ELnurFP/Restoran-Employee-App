class TimeConverter {
  final String? data;
  final String dayWord;
  final String hourWord;
  final String dayWordPlural;
  final String hourWordPlural;
  final String nowWord;
  final String unknownWord;

  bool isNow = false;
  String convertedString = '';

  TimeConverter(this.data, this.dayWord, this.hourWord, this.dayWordPlural,
      this.hourWordPlural, this.nowWord, this.unknownWord) {
    _convert();
  }

  void _convert() {
    if (data == null || data == '' || data == 'null') {
      convertedString = unknownWord;
      return;
    }

    final hours = int.tryParse(data!) ?? 0;

    if (hours == 0) {
      isNow = true;
      convertedString = nowWord;
    } else if (hours < 24) {
      convertedString = '$hours ${hours == 1 ? hourWord : hourWordPlural}';
    } else {
      final days = hours ~/ 24;
      final remainingHours = hours % 24;
      final dayStr = '$days ${days == 1 ? dayWord : dayWordPlural}';
      final hourStr = remainingHours == 0
          ? ''
          : '$remainingHours ${remainingHours == 1 ? hourWord : hourWordPlural}';
      final separator = hourStr.isEmpty ? '' : ' ';
      convertedString = '$dayStr$separator$hourStr';
    }
  }
}
