import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/utils.dart';

class Home extends StatefulWidget {
  Home({super.key}) {
    solveMaze();
  }

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Container(
          alignment: Alignment.centerRight,
          child:
              const Text("ساخت ماز", style: TextStyle(color: Colors.black54)),
        ),
        // leading: IconButton(
        //   onPressed: () {
        //     step = 0;
        //     resetMaze();
        //     Get.offNamed('/splash');
        //   },
        //   icon: const Icon(Icons.restart_alt_rounded),
        //   color: Colors.black54,
        // ),
      ),
      body: Container(
        alignment: Alignment.center,
        child: isPhone()
            ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ColorGuide(title: "هدف", color: Colors.green),
                          ColorGuide(title: "شروع", color: Colors.blue),
                          ColorGuide(title: "دیوار", color: Colors.black),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Container(
                        height: screenHeight * 0.35,
                        width: screenWidth * 0.5,
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Center(
                          child: GridView.count(
                              shrinkWrap: true,
                              crossAxisCount: 10,
                              children: List.generate(100, (index) {
                                return Container(
                                    decoration: BoxDecoration(
                                      color: getMazeCellsColor(index),
                                      border: calculateBorderForCells(index),
                                    ),
                                    child: Container(
                                      height: 1,
                                      width: 1,
                                      margin: const EdgeInsets.all(3),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        color: botMaze[indexToOffset(index)[0]]
                                                    [indexToOffset(index)[1]]
                                                .isBotHere
                                            ? Colors.orange
                                            : Colors.transparent,
                                      ),
                                    ));
                              })),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // ColorGuide(title: "مسیر طی شده", color: Colors.orange),
                              ColorGuide(
                                  title: "خانه ناشناخته", color: Colors.grey),
                              ColorGuide(title: "هدف", color: Colors.green),
                              ColorGuide(title: "شروع", color: Colors.blue),
                              ColorGuide(title: "دیوار", color: Colors.black),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Container(
                            height: screenHeight * 0.25,
                            width: screenWidth * 0.4,
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Center(
                              child: GridView.count(
                                shrinkWrap: true,
                                crossAxisCount: 10,
                                children: List.generate(
                                  100,
                                  (index) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        color: getBotMazeCellsColor(index),
                                        border: calculateBorderForCells(index),
                                      ),
                                      child: Container(
                                        height: 1,
                                        width: 1,
                                        margin: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          color: botMaze[indexToOffset(
                                                          index)[0]]
                                                      [indexToOffset(index)[1]]
                                                  .isBotHere
                                              ? Colors.orange
                                              : Colors.transparent,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text("درک ربات از محیط"),
                        ],
                      ),
                    ],
                  )
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          const Row(
                            children: [
                              // ColorGuide(title: "مسیر طی شده", color: Colors.orange),
                              ColorGuide(
                                  title: "خانه ناشناخته", color: Colors.grey),
                              ColorGuide(title: "هدف", color: Colors.green),
                              ColorGuide(title: "شروع", color: Colors.blue),
                              ColorGuide(title: "دیوار", color: Colors.black),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Container(
                            height: screenHeight * 0.4,
                            width: screenWidth * 0.2,
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Center(
                              child: GridView.count(
                                shrinkWrap: true,
                                crossAxisCount: 10,
                                children: List.generate(
                                  100,
                                  (index) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        color: getBotMazeCellsColor(index),
                                        border: calculateBorderForCells(index),
                                      ),
                                      child: Container(
                                        height: 1,
                                        width: 1,
                                        margin: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          color: botMaze[indexToOffset(
                                                          index)[0]]
                                                      [indexToOffset(index)[1]]
                                                  .isBotHere
                                              ? Colors.orange
                                              : Colors.transparent,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text("درک ربات از محیط"),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Row(
                        children: [
                          ColorGuide(title: "هدف", color: Colors.green),
                          ColorGuide(title: "شروع", color: Colors.blue),
                          ColorGuide(title: "دیوار", color: Colors.black),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Container(
                        height: screenHeight * 0.8,
                        width: screenWidth * 0.4,
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Center(
                          child: GridView.count(
                              shrinkWrap: true,
                              crossAxisCount: 10,
                              children: List.generate(100, (index) {
                                return Container(
                                    decoration: BoxDecoration(
                                      color: getMazeCellsColor(index),
                                      border: calculateBorderForCells(index),
                                    ),
                                    child: Container(
                                      height: 1,
                                      width: 1,
                                      margin: const EdgeInsets.all(15),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        color: botMaze[indexToOffset(index)[0]]
                                                    [indexToOffset(index)[1]]
                                                .isBotHere
                                            ? Colors.orange
                                            : Colors.transparent,
                                      ),
                                    ));
                              })),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (step != 0) {
              botMaze[path[step - 1].row][path[step - 1].col].isBotHere = false;
              maze[path[step - 1].row][path[step - 1].col].isBotHere = false;
            }
            if (step + 1 < path.length) {
              botMaze[path[step].row][path[step].col].isBotHere = true;
              maze[path[step].row][path[step].col].isBotHere = false;

              botMaze[path[step].row][path[step].col].isVisited = true;
              botMaze[path[step].row][path[step].col].value =
                  maze[path[step].row][path[step].col].value;

              if (wallSeenSteps.isNotEmpty &&
                  wallSeenSteps.first.step == step) {
                botMaze[wallSeenSteps.first.cell.row]
                        [wallSeenSteps.first.cell.col]
                    .value = 1;
                wallSeenSteps.removeAt(0);
              }
              step++;
            } else if (maze[path[step].row][path[step].col].value == 2) {
              Get.snackbar(
                "اتمام موفق جستجو",
                "هدف با موفقیت در سطر ${path[step - 1].row + 1} و ستون ${path[step - 1].col + 1} پیدا شد.",
                backgroundColor: Colors.green,
                colorText: Colors.white,
                icon: const Icon(
                  Icons.check_circle_rounded,
                  color: Colors.white,
                ),
              );

              botMaze[path[step].row][path[step].col].isBotHere = true;
              maze[path[step].row][path[step].col].isBotHere = true;

              botMaze[path[step].row][path[step].col].isVisited = true;
              botMaze[path[step].row][path[step].col].value = 2;
            } else {
              Get.snackbar(
                "اتمام ناموفق جستجو",
                "هدف در محیط یافت نشد.",
                backgroundColor: Colors.red,
                colorText: Colors.white,
                icon: const Icon(
                  Icons.error_rounded,
                  color: Colors.white,
                ),
              );
              botMaze[path[step].row][path[step].col].isBotHere = true;
              maze[path[step].row][path[step].col].isBotHere = true;

              botMaze[path[step].row][path[step].col].isVisited = true;
              botMaze[path[step].row][path[step].col].value = 0;
            }
          });
        },
        child: const Icon(
          Icons.next_plan_rounded,
          color: Colors.black54,
        ),
      ),
    );
  }
}

class ColorGuide extends StatelessWidget {
  final String title;
  final Color color;

  const ColorGuide({
    super.key,
    required this.title,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 10),
        Text(title, style: TextStyle(color: color)),
        const SizedBox(width: 10),
        Container(
          height: 10,
          width: 10,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: color,
          ),
        ),
      ],
    );
  }
}
