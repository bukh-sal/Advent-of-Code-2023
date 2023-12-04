// ignore_for_file: non_constant_identifier_names

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

void addHeatPoint(int row, int col, [int radius = 1, includeCorners=true]){
  int minRow = max(0, row - radius);
  int minCol = max(0, col - radius);

  int maxRow = min(lineCount - 1, row + radius);
  int maxCol = min(lineLength, col + radius);

  if (includeCorners) { 
    for (int rowIdx = minRow; rowIdx <= maxRow; rowIdx++){
      for (int colIdx = minCol; colIdx <= maxCol; colIdx++){
        heatMap[rowIdx][colIdx] = 1;
      }
    }
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
    String tmpLine = line.replaceAll(".", "Z");
    tmpLine = tmpLine.replaceAll(RegExp(r"[^\w\s]"), 'X');
    List<String> lineItems = tmpLine.split('');
    for (int charIdx = 0; charIdx < lineItems.length; charIdx++) {
      String char = lineItems[charIdx];
      if (char == "X") {
        lineItems[charIdx] = 'Z';
        addHeatPoint(line_idx, charIdx);
      }
    }
  }
}


void main(List<String> arguments) {
  List<String> raw = File('input.txt').readAsLinesSync();
  for (var element in raw) {
    element = element.replaceAll(' ', '.');
  }

  int unique_sol = 0;
  int total_sum = 0;
  //print(raw);
  List<int> uniqueIncludedNums = [];
  List<int> includedNums = [];

  lineCount = raw.length;
  lineLength = raw[0].length;
  generateHeatMap(raw);


  fillHeatMap(raw);

  for (int line_idx = 0; line_idx < raw.length; line_idx++){
    String line = raw[line_idx];
    line = replaceSymbols(line);


    List<String> sep = line.split('.');
    for (var item in sep){
      if (item == '0' || item == ""){
        continue;
      }

      int startsFrom = line.indexOf(item);
      int endsAt = startsFrom + item.length - 1;
      List<Map<int, int>> locations = [];


      bool isIn = false;
      for (int loc = startsFrom; loc <= endsAt; loc++){
        locations.add({line_idx:loc});
        //print('$item - checked location $line_idx $loc');
        if (heatMap[line_idx][loc] == 1){
          isIn = true;
        }
      }

      //print('item $item has locations $locations');
      if (isIn){
        stdout.write('$item ');
        int partNumber = int.parse(item);

        total_sum = total_sum + partNumber;
        includedNums.add(partNumber);

        if (!uniqueIncludedNums.contains(partNumber)){
        unique_sol = unique_sol + partNumber;
        uniqueIncludedNums.add(partNumber);
        }
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

  print("Unique Values Sum = $unique_sol");
  print("All Values Sum    = $total_sum");
}
