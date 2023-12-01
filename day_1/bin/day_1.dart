import 'dart:io';

List<int> parseNumbers(String text) {
  print('before $text');

  text = text.replaceAll('one', '1');
  text = text.replaceAll('two', '2');
  text = text.replaceAll('six', '6');

  text = text.replaceAll('four', '4');
  text = text.replaceAll('five', '5');
  text = text.replaceAll('nine', '9');

  text = text.replaceAll('three', '3');
  text = text.replaceAll('seven', '7');
  text = text.replaceAll('eight', '8');

  print('after $text');

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
