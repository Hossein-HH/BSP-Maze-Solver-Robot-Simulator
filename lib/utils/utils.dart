import 'package:flutter/material.dart';
import 'package:get/get.dart';

late double screenWidth;
late double screenHeight;

class MazeCelll {
  int value;
  bool isBotHere;

  MazeCelll({required this.value, required this.isBotHere});
}

class BotMazeCelll {
  int value;
  bool isBotHere;
  bool isVisited;

  BotMazeCelll({
    required this.value,
    required this.isBotHere,
    required this.isVisited,
  });
}

// 0 means empty cell
// 1 means wall
// 2 means goal
List<List<MazeCelll>> maze = List.generate(
    10,
    (index) =>
        List.generate(10, (index) => MazeCelll(value: 0, isBotHere: false)));

// -1 means unknown cell
List<List<BotMazeCelll>> botMaze = List.generate(
    10,
    (index) => List.generate(
        10,
        (index) =>
            BotMazeCelll(value: -1, isBotHere: false, isVisited: false)));

// 0 means empty cell
// 1 means wall
// 2 means goal
List<List<MazeCelll>> pathInMaze = List.generate(
    10,
    (index) =>
        List.generate(10, (index) => MazeCelll(value: 0, isBotHere: false)));

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
  switch (maze[indexToOffset(index)[0]][indexToOffset(index)[1]].value) {
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
  switch (botMaze[indexToOffset(index)[0]][indexToOffset(index)[1]].value) {
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

List<int> search2DList(List<List<MazeCelll>> list, int searchValue) {
  for (var i = 0; i < list.length; i++) {
    for (var j = 0; j < list[i].length; j++) {
      if (list[i][j].value == searchValue) {
        return [i, j];
      }
    }
  }
  return [-1, -1];
}

// void mazeSolver(StateSetter setState) {
//   List<int> start = search2DList(maze, -2);
//   List<int> goal = search2DList(maze, 2);

//   setState(() {
//     maze[start[0]][start[1]].isBotHere = true;
//   });

//   List<List<List<int>>> stack = [
//     [start, <int>[]]
//   ];

//   List<int> current = [];
//   List<List<int>> path = [];

//   while (stack.isNotEmpty) {
//     // if (botMaze[current[0]][current[1]].isVisited == true) {
//     current = stack.last[0];
//     path.add(stack.last[0]);
//     stack.removeLast();
//     // }

//     // Check the current cell
//     int x = current[0];
//     int y = current[1];
//     if (maze[x][y].value == 1) {
//       setState(() {
//         botMaze[x][y].value = 1;
//       });
//       continue;
//     }
//     if (maze[x][y].value == 2) {
//       setState(() {
//         botMaze[x][y].value = 2;
//       });
//       goal = current;
//       Get.snackbar(
//         'هدف',
//         'هدف در مختصات $goal یافت شد.',
//         backgroundColor: Colors.green,
//         colorText: Colors.white,
//         icon: const Icon(
//           Icons.warning_amber_rounded,
//           color: Colors.white,
//         ),
//       );
//       // var f = File('robot_path.txt');
//       // f.writeAsStringSync('Reached the goal at $goal\n', mode: FileMode.append);
//       break;
//     }

//     setState(() {
//       botMaze[x][y].value = 0;
//     });

//     // Move to neighboring cells
//     // maze[x][y].value = 1;
//     // add current to path
//     // path.add(current);
//     // var f = File('robot_path.txt');
//     setState(() {
//       maze[current[0]][current[1]].isBotHere = true;
//     });

//     // f.writeAsStringSync('Moved to ($x, $y)\n', mode: FileMode.append);
//     if (x > 0) {
//       stack.add([
//         [x - 1, y],
//         List.of(path.expand((element) => element).toList())
//       ]);
//       // setState(() {
//       //   botMaze[x - 1][y].value = maze[x - 1][y].value;
//       // });
//     }
//     if (x < maze.length - 1) {
//       stack.add([
//         [x + 1, y],
//         List.of(path.expand((element) => element).toList())
//       ]);
//       // setState(() {
//       //   botMaze[x + 1][y].value = maze[x + 1][y].value;
//       // });
//     }
//     if (y > 0) {
//       stack.add([
//         [x, y - 1],
//         List.of(path.expand((element) => element).toList())
//       ]);
//       // setState(() {
//       //   botMaze[x][y - 1].value = maze[x][y - 1].value;
//       // });
//     }
//     if (y < maze[0].length - 1) {
//       stack.add([
//         [x, y + 1],
//         List.of(path.expand((element) => element).toList())
//       ]);
//       // setState(() {
//       //   botMaze[x][y + 1].value = maze[x][y + 1].value;
//       // });
//     }

//     // Print the robot's path
//     // ignore: unnecessary_null_comparison
//     // if (goal != null) {
//     // path.add(goal);
//     // var f = File('robot_path.txt');
//     // debugPrint('Path taken by the robot:');
//     // f.writeAsStringSync('Path taken by the robot:\n', mode: FileMode.append);
//     // for (var p in path) {
//     // debugPrint('(${p[0]}, ${p[1]})');
//     // f.writeAsStringSync('(${p[0]}, ${p[1]})\n', mode: FileMode.append);
//     // }
//     // } else {
//     // debugPrint("Could not reach the goal");
//     // var f = File('robot_path.txt');
//     // f.writeAsStringSync('Could not reach the goal\n', mode: FileMode.append);
//     // }
//   }
// }

RxBool found = false.obs;

List<List<int>> directions = [
  [-1, 0], // up
  [0, 1], // right
  [1, 0], // down
  [0, -1] // left
];

List<List<int>> solveMaze() {
  int rows = maze.length;
  int cols = maze[0].length;
  List<int> start = search2DList(maze, -2);
  List<List<int>> visited = List.generate(rows, (_) => List.filled(cols, 0));
  dfs(start[0], start[1], visited);
  return visited;
}

void dfs(int row, int col, List<List<int>> visited) {
  visited[row][col] = 1;
  if (maze[row][col].value == 2) {
    found.value = true;
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
    }
  }
}
