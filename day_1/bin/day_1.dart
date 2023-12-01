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
  String text = 'pqr3stu8vwx';
  List<int> textAsInts = parseNumbers(text);
  print(textAsInts);
}
