import 'package:flutter/material.dart';
import 'package:get/get.dart';

late double screenWidth;
late double screenHeight;
int step = -1;

class MazeCell {
  int value;
  bool isBotHere;

  MazeCell({required this.value, required this.isBotHere});
}

class BotMazeCell {
  int value;
  bool isBotHere;
  bool isVisited;

  BotMazeCell({
    required this.value,
    required this.isBotHere,
    required this.isVisited,
  });
}

class Cell {
  int row;
  int col;

  Cell({required this.row, required this.col});
}

class WallSeenStep {
  int step;
  Cell cell;

  WallSeenStep({required this.cell, required this.step});
}

// 0 means empty cell
// 1 means wall
// 2 means goal
List<List<MazeCell>> maze = List.generate(
    10,
    (index) =>
        List.generate(10, (index) => MazeCell(value: 0, isBotHere: false)));

// -1 means unknown cell
List<List<BotMazeCell>> botMaze = List.generate(
    10,
    (index) => List.generate(10,
        (index) => BotMazeCell(value: -1, isBotHere: false, isVisited: false)));

List<Cell> path = [];
List<WallSeenStep> wallSeenSteps = [];

// a func for re set the maze and botMaze and path
void resetMaze() {
  step = 0;

  maze = List.generate(
      10,
      (index) =>
          List.generate(10, (index) => MazeCell(value: 0, isBotHere: false)));
  botMaze = List.generate(
      10,
      (index) => List.generate(
          10,
          (index) =>
              BotMazeCell(value: -1, isBotHere: false, isVisited: false)));
  path = [];
}

void calculateScreenSize(BuildContext context) {
  screenWidth = MediaQuery.of(context).size.width;
  screenHeight = MediaQuery.of(context).size.height;
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
  switch (maze[indexToOffset(index)[0]][indexToOffset(index)[1]].value) {
    case 0:
      // 0 is empty
      return Colors.white;
    case 1:
      // 1 is start
      return Colors.black87;
    case -2:
      // -2 is start
      return Colors.blue.shade400;
    case 2:
      // 2 is goal
      return Colors.green.shade400;
    default:
      return Colors.purple.shade400;
  }
}

Color? getBotMazeCellsColor(index) {
  switch (botMaze[indexToOffset(index)[0]][indexToOffset(index)[1]].value) {
    case -2:
      // -1 is unknown
      return Colors.blue.shade400;
    case -1:
      // -1 is unknown
      return Colors.grey;
    case 0:
      // 0 is empty
      return Colors.white;
    case 1:
      // 1 is wall
      return Colors.black87;
    case 2:
      // 2 is goal
      return Colors.green.shade400;
    default:
      return Colors.purple.shade300;
  }
}

List<int> search2DList(List<List<MazeCell>> list, int searchValue) {
  for (var i = 0; i < list.length; i++) {
    for (var j = 0; j < list[i].length; j++) {
      if (list[i][j].value == searchValue) {
        return [i, j];
      }
    }
  }
  return [-1, -1];
}

RxBool found = false.obs;

List<List<int>> directions = [
  [-1, 0], // up
  [0, 1], // right
  [1, 0], // down
  [0, -1] // left
];

void solveMaze() {
  int rows = maze.length;
  int cols = maze[0].length;
  List<int> start = search2DList(maze, -2);
  List<List<int>> visited = List.generate(rows, (_) => List.filled(cols, 0));
  dfs(start[0], start[1], visited);

  step = 0;
  // Get.back();
}

void dfs(int row, int col, List<List<int>> visited) {
  visited[row][col] = 1;
  path.add(Cell(row: row, col: col));
  step++;

  if (maze[row][col].value == 2) {
    found.value = true;
    // debugPrint("هدف با موفقیت در سطر ${row + 1} و ستون ${col + 1} پیدا شد.");
    return;
  }
  for (List<int> direction in directions) {
    int newRow = row + direction[0];
    int newCol = col + direction[1];
    if (newRow >= 0 &&
        newRow < maze.length &&
        newCol >= 0 &&
        newCol < maze[0].length &&
        maze[newRow][newCol].value != 1 &&
        visited[newRow][newCol] == 0 &&
        !found.value) {
      dfs(newRow, newCol, visited);
    } else if (newRow >= 0 &&
        newRow < maze.length &&
        newCol >= 0 &&
        newCol < maze[0].length &&
        maze[newRow][newCol].value == 1) {
      wallSeenSteps
          .add(WallSeenStep(cell: Cell(row: newRow, col: newCol), step: step));
    }
  }
}

List<double> getCellSize() {
  double scale = screenWidth / screenHeight;

  if (scale > 0.6) {
    return [screenHeight * 0.8, screenWidth * 0.4];
  } else {
    return [screenHeight * 0.4, screenWidth * 0.8];
  }
}

bool isPhone() {
  double scale = screenWidth / screenHeight;

  if (scale > 0.6) {
    return false;
  } else {
    return true;
  }
}
