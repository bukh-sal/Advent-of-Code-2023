import 'dart:io';

void main(List<String> arguments) {
  List<String> games = File('input.txt').readAsLinesSync();

  int maxRed = 12;
  int maxGreen = 13;
  int maxBlue = 14;
  List<int> validGames = [];
  List<List<int>> maxColorValues = [];

  for (int i = 0; i < games.length; i++) {

    bool         gameIsValid = true;
    String       game        = games[i];
    String       gameId      = game.split(':')[0];
    String       gameDraws   = game.split(':')[1].trim();
    List<String> draws       = gameDraws.split(';');
    Map<String, int> maxColor = {"red": 0, "green": 0, "blue": 0};

    gameId = gameId.split('Game')[1];

    for (int a = 0; a < draws.length; a++) {
      Map<String, int> colorCount = {"red": 0, "green": 0, "blue": 0};
      String draw = draws[a];
      List<String> cubes = draw.split(',');
      for (var element in cubes) {
        String cleanedName = element.trim();
        cubes[cubes.indexOf(element)] = cleanedName;
      }

      for (var element in cubes) {
        String color = element.split(' ')[1];
        int value = int.parse(element.split(' ')[0]);
        int currentValue = colorCount[color]!;
        colorCount[color] = currentValue + value;


        int currentMax = maxColor[color]!;
        if (value > currentMax){
          maxColor[color] = value;
        }

      }

      if (colorCount["red"]! > maxRed) {
        gameIsValid = false;
      }
      else if (colorCount["green"]! > maxGreen) {
        gameIsValid = false;
      }
      else if (colorCount["blue"]! > maxBlue) {
        gameIsValid = false;
      }
      else {
      }
    }

    List<int> values = [ maxColor['red']!, maxColor['green']!, maxColor['blue']! ];
    maxColorValues.add(values);
    
    if (gameIsValid) {
      validGames.add(int.parse(gameId));
    }

  }
  print('valid games: $validGames');

  int idTotal = 0;
  for (var element in validGames){
    idTotal = idTotal + element;
  }

  print("result $idTotal");
  print(maxColorValues);

  double multiTotal = 0;
  for (int game = 0; game < maxColorValues.length; game++) {
    List<int> gameMins = maxColorValues[game];
    multiTotal = multiTotal + (gameMins[0] * gameMins[1] * gameMins[2]);
  }

  print('power total = $multiTotal');

}
