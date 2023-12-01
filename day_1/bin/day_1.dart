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

  int total = 0;
  for (int i = 0; i < text.length; i++) {
    List<int> entry = parseNumbers(text[i]);
    int firstNumber = entry[0];
    int lastNumber = entry[entry.length - 1];
    total = total + firstNumber * 10 + lastNumber;
  }

  print(total);
}
