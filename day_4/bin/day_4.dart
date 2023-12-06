// ignore_for_file: non_constant_identifier_names


import 'dart:io';
import 'dart:math';

List<int> cardsValues = [];
List<int> cardFreebiesCount = [];
int totalCardCount = 0;

void mapsInit(){
  int cardCount = File('input.txt').readAsLinesSync().length;
  for (int i = 0; i < cardCount; i++){
    cardsValues.add(-1);
    cardFreebiesCount.add(-1);
  }
}

int get_card_wins(String line) {
    int lineIdx = og_lines.indexOf(line);
    if (cardsValues[lineIdx] == -1) {
        print("Trigerred");
        int value = 0;
        int winCount = 0;

        List<int> wining_numbers = parse_numbers(line, true);
        List<int> card_numbers = parse_numbers(line, false);
        for (int cardIdx = 0; cardIdx < card_numbers.length; cardIdx++){
            int card = card_numbers[cardIdx];
            if (wining_numbers.contains(card)){
                winCount++;
                if (value == 0){
                    value = 1;
                } else {
                    value = value * 2;
                }
            }
        }
        cardsValues[lineIdx] = value;
        cardFreebiesCount[lineIdx] = winCount;
        return value;
    }
    
    return cardsValues[lineIdx];
}

int get_card_win_count(String line){
    int lineIdx = og_lines.indexOf(line);
    return cardFreebiesCount[lineIdx];
}

List<int> parse_numbers(String line, bool wining){
  List<int> results = [];
  line = line.split(':')[1];
  int idx = 1;
  if (wining){ idx = 0; }
  
  line = line.split('|')[idx];
  line = line.trim();
  List<String> nums = line.split(' ');
  
  for (var num in nums){
    int? v = int.tryParse(num);
    if (v != null){
      results.add(v);
    }
  }
  return results;
}

List<String> og_lines = [];
List<String> freebies = [];
bool loaded_contents = false;

int processCards(){
  List<String> contents = [];
  if (!loaded_contents){
    contents = File('input.txt').readAsLinesSync();
    og_lines = contents;
    loaded_contents = true;
  } else {
    contents = freebies;
    freebies = [];
    print('Newly Found ${contents.length} ');
  }

  totalCardCount = totalCardCount + contents.length;
  int total = 0;
  for (int lineIdx = 0; lineIdx < contents.length; lineIdx++){
    String line = contents[lineIdx];
    int cardOrder = og_lines.indexOf(line);
    int winings = get_card_wins(line);
    int cardsFound = get_card_win_count(line);


      if (cardsFound > 0){
        for (int z = 0; z < cardsFound; z++){
            int t_line_idx = cardOrder + 1 + z;
            if (t_line_idx >= contents.length){
                break;
            }

            String t_line = og_lines[t_line_idx];
            freebies.add(t_line);
        }
      }

    total = total + winings;
  }
  return total;
}

void main(List<String> arguments) {
  mapsInit();


  print('stage 1 = ${processCards()}');

  int stage_2 = 0;
  bool done = false;

  while(!done){
    int total = processCards();
    stage_2 = stage_2 + total;

    if (total == 0){
      done = true;
    }
    
  }

  print('sum stage 2 = $stage_2');
  print('stage 2 = $totalCardCount');

  

}
