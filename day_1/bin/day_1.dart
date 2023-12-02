import 'dart:io';

String rollingReplace(String text) {
  int textLength = text.length;
  int startAt = 0;
  int distanceToEnd = text.length;
  while (startAt < textLength) {
    bool found = false;

    // 3 letter
    if (text.length - startAt >= 3) {
      String prefix = text.substring(0, startAt);
      String part_1 = text.substring(startAt, startAt + 3);
      String part_2 = text.substring(startAt + 3);

      if (part_1.contains('one') |
          part_1.contains('two') |
          part_1.contains('six')) {
        found = true;
      }

      part_1 = part_1.replaceAll('one', '1e');
      part_1 = part_1.replaceAll('two', '2o');
      part_1 = part_1.replaceAll('six', '6s');

      text = prefix + part_1 + part_2;
      textLength = text.length;
    }

    // 4 letter
    if (text.length - startAt >= 4) {
      String prefix = text.substring(0, startAt);
      String part_1 = text.substring(startAt, startAt + 4);
      String part_2 = text.substring(startAt + 4);

      if (part_1.contains('four') |
          part_1.contains('five') |
          part_1.contains('nine')) {
        found = true;
      }

      part_1 = part_1.replaceAll('four', '4r');
      part_1 = part_1.replaceAll('five', '5e');
      part_1 = part_1.replaceAll('nine', '9e');

      text = prefix + part_1 + part_2;
      textLength = text.length;
    }

    // 5 letter
    if (text.length - startAt >= 5) {
      String prefix = text.substring(0, startAt);
      String part_1 = text.substring(startAt, startAt + 5);
      String part_2 = text.substring(startAt + 5);

      if (part_1.contains('three') |
          part_1.contains('seven') |
          part_1.contains('eight')) {
        found = true;
      }

      part_1 = part_1.replaceAll('three', '3e');
      part_1 = part_1.replaceAll('seven', '7n');
      part_1 = part_1.replaceAll('eight', '8t');

      text = prefix + part_1 + part_2;
      textLength = text.length;
    }

    if (!found) {
      startAt++;
    }
  }

  return text;
}

List<int> parseNumbers(String text) {
  text = rollingReplace(text);

  List<String> textAsList = text.split('');
  List<int> results = [];

  for (int i = 0; i < textAsList.length; i++) {
    try {
      int number = int.parse(textAsList[i]);
      results.add(number);
    } catch (e) {
      continue;
    }
  }

  return results;
}

void main(List<String> arguments) {
  List<String> text = File('input.txt').readAsLinesSync();
  int total = 0;
  for (int i = 0; i < text.length; i++) {
    List<int> entry = parseNumbers(text[i]);
    int firstNumber = entry[0];
    int lastNumber = entry[entry.length - 1];
    int sum = firstNumber * 10 + lastNumber;
    total = total + sum;
  }

  print(total);
}
