import 'dart:io';

List<int> parseNumbers(String text) {
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
  List<int> textAsInts = parseNumbers(text[0]);
  print(textAsInts);
}
