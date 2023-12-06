// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:io';
import 'dart:math';


String replaceSymbols(String line, [String replaceWith = "."]){
    line = line.replaceAll(RegExp(r"[^\w\s]"), replaceWith);
    return line;
}

List<List<int>> heatMap = [];
int lineLength = 0;
int lineCount = 0;

void generateHeatMap(List<String> raw){
  for (int i = 0; i < raw.length; i++){
    int len = raw[i].length;
    List<int> zeros = List.filled(len, 0);
    heatMap.add(zeros);
  }
}

void addHeatPoint(int row, int col){
  bool includeCorners=true;
  
  int minRow = max(0, row - 1);
  int minCol = max(0, col - 1);

  int maxRow = min(lineCount - 1, row + 1);
  int maxCol = min(lineLength - 1, col + 1);

  if (includeCorners) { 
    for (int rowIdx = minRow; rowIdx <= maxRow; rowIdx++){
      for (int colIdx = minCol; colIdx <= maxCol; colIdx++){
        heatMap[rowIdx][colIdx] = 1;
      }
    }
  // ignore: dead_code
  } else {
    heatMap[row][col] = 1;
    heatMap[minRow][col] = 1;
    heatMap[maxRow][col] = 1;
    heatMap[row][minCol] = 1;
    heatMap[row][maxCol] = 1;
  }
}

void fillHeatMap(List<String> raw) {
  for (int line_idx = 0; line_idx < raw.length; line_idx++){
    String line = raw[line_idx];

    line = line.replaceAll(".", "N");
    line = line.replaceAll(RegExp(r"[^\w\s]"), 'X');

    List<String> lineChars = line.split('');
    for (int charIdx = 0; charIdx < lineChars.length; charIdx++) {
      String char = lineChars[charIdx];
      if (char == 'X') {
        lineChars[charIdx] = 'N';
        addHeatPoint(line_idx, charIdx);
      }
    }

  }
}

List<String> get_numbers(String line){
  List<String> numbers = [];

  String stack = '';

  List<String> validChars = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0'];

  List<String> letters = line.split('');
  for (int charIdx = 0; charIdx < letters.length; charIdx++){
    String char = letters[charIdx];
    if (validChars.contains(char)) {
      stack = stack + char;
    } else {
      if (stack != '') {
        numbers.add(stack);
      }
      stack = '';
    }

  }

  return numbers;
}


void main(List<String> arguments) {
  List<String> raw = File('input.txt').readAsLinesSync();

  int total_sum = 0;
  List<int> includedNums = [];

  lineCount = raw.length;
  lineLength = raw[0].length;
  generateHeatMap(raw);


  fillHeatMap(raw);

  for (int line_idx = 0; line_idx < raw.length; line_idx++){
    String line = raw[line_idx];
    String modedLine = replaceSymbols(line);

    //List<String> numbers = get_numbers(modedLine);
    List<String> sep = modedLine.split('.');    

    for (var number in sep){
      int startsFrom = line.indexOf(number);
      int endsAt = startsFrom + number.length - 1;
      bool isIn = false;


      for (int loc = startsFrom; loc <= endsAt; loc++){
        if (heatMap[line_idx][loc] == 1){
          isIn = true;
        }
      }

      if (isIn){
        stdout.write('$number ');
        int partNumber = int.parse(number);
        total_sum = total_sum + partNumber;
        includedNums.add(partNumber);
      }
    }
        stdout.write('\n');
  }




  print('-----------------');
  int total_inc = 0;
  for (int a = 0; a < includedNums.length; a++){
      total_inc = total_inc + includedNums[a];
  }

  print('total of included nums $total_inc');
  print("All Values Sum    = $total_sum");
}
