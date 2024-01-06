// ignore_for_file: non_constant_identifier_names

import 'dart:io';

List<int> get_seeds(String raw) {
  List<int> seeds = [];
  raw = raw.split('seed-to-soil map:')[0].split('seeds:')[1];
  List<String> rawNums = raw.split(' ');
  for (var seed in rawNums) {
    int? v = int.tryParse(seed);
    if (v != null) { seeds.add(v); }
  }
  return seeds;
}

List<List<int>> get_seed_to_soil_map(String raw) {
  List<List<int>> seed_to_soil = [];
  raw = raw.split('soil-to-fertilizer map:')[0].split('seed-to-soil map:')[1];
  List<String> lines = raw.split('\n');
  for (var line in lines) {
    List<int> line_data = [];
    List<String> line_nums = line.split(' ');
    for (var num in line_nums) {
      int? v = int.tryParse(num);
      if (v != null) { line_data.add(v); }
    }
    if (line_data.isNotEmpty){
      seed_to_soil.add(line_data);
    }
  }

  return seed_to_soil;
}

void main(List<String> arguments) {
  String contents = File('input.txt').readAsStringSync();
  print(get_seeds(contents));
  print(get_seed_to_soil_map(contents));
}
