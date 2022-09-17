import 'package:dogventurehq/states/models/puzzle.dart';

class PuzzleData {
  static List<PuzzleItem> puzzleList = <PuzzleItem>[
    PuzzleItem(
      name: 'LION',
      question: 'What animal is this?',
      image: 'assets/imgs/animals/lion.jpg',
      score: 10,
      charList: [
        'L',
        'Y',
        'I',
        'F',
        'T',
        'U',
        'O',
        'N',
      ],
    ),
    PuzzleItem(
      name: 'TIGER',
      question: 'What animal is this?',
      image: 'assets/imgs/animals/tiger.jpg',
      score: 10,
      charList: [
        'G',
        'Y',
        'I',
        'F',
        'T',
        'U',
        'E',
        'R',
      ],
    ),
    PuzzleItem(
      name: 'DEER',
      question: 'What animal is this?',
      image: 'assets/imgs/animals/deer.jpg',
      score: 10,
      charList: [
        'E',
        'N',
        'D',
        'T',
        'R',
        'U',
        'E',
        'Z',
      ],
    ),
  ];
}
