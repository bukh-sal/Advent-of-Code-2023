import 'dart:io';

void main(List<String> arguments) {
  List<String> games = File('input.txt').readAsLinesSync();

  int maxRed = 12;
  int maxGreen = 13;
  int maxBlue = 14;
  List<int> validGames = [];

  print(games);

  for (int i = 0; i < games.length; i++) {
    Map<String, int> colorCount = {"red": 0, "green": 0, "blue": 0};

    String game = games[i];
    String gameId = game.split(':')[0];
    gameId = gameId.split('Game')[1];

    String gameDraws = game.split(':')[1].trim();

    List<String> draws = gameDraws.split(';');
    for (int a = 0; a < draws.length; a++) {
      String draw = draws[a];
      List<String> cubes = draw.split(',');
      for (var element in cubes) {
        cubes[cubes.indexOf(element)] = element.trim();
      }

      print('in draw $a there was $cubes');
    }

    print(draws);

    print('Game ID = $gameId');

    String text = '123 Gm';
    int myNum = int.parse(text.substring(0, text.indexOf(' ')));
    print(myNum);
  }
}
