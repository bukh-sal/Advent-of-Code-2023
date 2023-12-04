// ignore_for_file: non_constant_identifier_names

import 'dart:io';
import 'dart:math';

import 'package:image/image.dart';

void saveAsImage(List<List<int>> heatMap, String path) {
  int width = heatMap[0].length;
  int height = heatMap.length;
  print('width: $width, height: $height');

  Image image = Image(height: height, width: width);

  for (int row = 0; row < height; row++){
    for (int col = 0; col < width; col++){
      if (heatMap[row][col] == 1){
        image.setPixelRgba(col, row, 255, 255, 255, 255);
      } else {
        image.setPixelRgba(col, row, 0, 0, 0, 255);
      }
    }
  }

  File(path).writeAsBytesSync(encodePng(image));
}

String replaceSymbols(String line, [String replaceWith = "."]){
    line = line.replaceAll(RegExp(r"[^\w\s]"), replaceWith);
    print(line);
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

void addHeatPoint(int row, int col, [int radius = 1]){
  int minRow = max(0, row - radius);
  int minCol = max(0, col - radius);

  int maxRow = min(lineCount - 1, row + radius);
  int maxCol = min(lineLength, col + radius);

  for (int rowIdx = minRow; rowIdx <= maxRow; rowIdx++){
    for (int colIdx = minCol; colIdx <= maxCol; colIdx++){
      heatMap[rowIdx][colIdx] = 1;
    }
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
        print('$lineItems has X is ${lineItems.contains('X')}');
        addHeatPoint(line_idx, charIdx);
      }
    }
    print('------');
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
        int partNumber = int.parse(item);

        total_sum = total_sum + partNumber;

        if (!includedNums.contains(partNumber)){
        unique_sol = unique_sol + partNumber;
        includedNums.add(partNumber);
        //print('added $item');
        }
      }
    }
  }



  print('-----------------');


  // save heat map as an image, where 0 is black and 1 is white


  saveAsImage(heatMap, 'heat_map.png');






  print("Unique Values Sum = $unique_sol");
  print("All Values Sum    = $total_sum");
}
