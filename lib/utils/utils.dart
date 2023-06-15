import 'package:flutter/material.dart';

late double screenWidth;
late double screenHeight;

// 0 means empty cell
// 1 means wall
// 2 means goal
List<List<int>> maze =
    List.generate(10, (index) => List.generate(10, (index) => 0));

// -1 means unknown cell
List<List<int>> botMaze =
    List.generate(10, (index) => List.generate(10, (index) => -1));

void calculateScreenSize(BuildContext context) {
  screenWidth = MediaQuery.of(context).size.width;
  screenHeight = MediaQuery.of(context).size.height;
}

BorderRadiusGeometry? calculateBorderRaduisForCorners(int index) {
  switch (index) {
    // case 0:
    //   return BorderRadius.only(
    //     topLeft: Radius.circular(screenWidth * 0.01),
    //   );
    // case 9:
    //   return BorderRadius.only(
    //     topRight: Radius.circular(screenWidth * 0.01 ),
    //   );
    // case 90:
    //   return BorderRadius.only(
    //     bottomLeft: Radius.circular(screenWidth * 0.01 ),
    //   );
    // case 99:
    //   return BorderRadius.only(
    //     bottomRight: Radius.circular(screenWidth * 0.01 ),
    //   );
    default:
      return null;
  }
}

BoxBorder? calculateBorderForCells(int index) {
  switch (index) {
    case 0:
      return const Border(
        top: BorderSide(color: Colors.black54),
        left: BorderSide(color: Colors.black54),
        right: BorderSide(color: Colors.black54),
      );
    case 9:
      return const Border(
        top: BorderSide(color: Colors.black54),
        right: BorderSide(color: Colors.black54),
      );
    case 90:
      return const Border(
          top: BorderSide(color: Colors.black54),
          left: BorderSide(color: Colors.black54),
          right: BorderSide(color: Colors.black54),
          bottom: BorderSide(color: Colors.black54));
    case 99:
      return const Border(
          top: BorderSide(color: Colors.black54),
          right: BorderSide(color: Colors.black54),
          bottom: BorderSide(color: Colors.black54));
    default:
      if (index % 10 == 0) {
        return const Border(
          top: BorderSide(color: Colors.black54),
          right: BorderSide(color: Colors.black54),
          left: BorderSide(color: Colors.black54),
        );
      }
      if (index > 90) {
        return const Border(
            top: BorderSide(color: Colors.black54),
            right: BorderSide(color: Colors.black54),
            bottom: BorderSide(color: Colors.black54));
      } else {
        return const Border(
          top: BorderSide(color: Colors.black54),
          right: BorderSide(color: Colors.black54),
        );
      }
  }
}

List<int> indexToOffset(int index) {
  return [index ~/ 10, index % 10];
}

Color? getMazeCellsColor(index) {
  switch (maze[indexToOffset(index)[0]][indexToOffset(index)[1]]) {
    case 0:
      // 0 is empty
      return Colors.white;
    case 1:
      // 1 is start
      return Colors.black;
    case -2:
      // -2 is start
      return Colors.red;
    case 2:
      // 2 is goal
      return Colors.green;
    default:
      return Colors.purple;
  }
}

Color? getBotMazeCellsColor(index) {
  switch (botMaze[indexToOffset(index)[0]][indexToOffset(index)[1]]) {
    case -1:
      // -1 is unknown
      return Colors.grey;
    case 0:
      // 0 is empty
      return Colors.white;
    case 1:
      // 1 is wall
      return Colors.black;
    case 2:
      // 2 is goal
      return Colors.green;
    default:
      return Colors.purple;
  }
}
