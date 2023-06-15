import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/utils.dart';

class Home extends StatefulWidget {
  const Home({super.key});

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
        ),
        body: Container(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      const Text("درک ربات از محیط"),
                      const SizedBox(height: 10),
                      Container(
                        height: screenHeight * 0.35,
                        width: screenWidth * 0.2,
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Center(
                          child: GridView.count(
                              shrinkWrap: true,
                              crossAxisCount: 10,
                              children: List.generate(100, (index) {
                                return Container(
                                  decoration: BoxDecoration(
                                    color: getBotMazeCellsColor(index),
                                    border: calculateBorderForCells(index),
                                    borderRadius:
                                        calculateBorderRaduisForCorners(index),
                                  ),
                                  child: InkWell(
                                    customBorder: RoundedRectangleBorder(
                                      borderRadius:
                                          calculateBorderRaduisForCorners(
                                                  index) ??
                                              BorderRadius.circular(0),
                                    ),
                                    onTap: () {
                                      List<int> offset = indexToOffset(index);
                                      if (maze[offset[0]][offset[1]] == 0) {
                                        maze[offset[0]][offset[1]] = 1;
                                        setState(() {});
                                      } else {
                                        Get.snackbar(
                                          "خطا",
                                          "در نقطه شروع و نقطه هدف امکان قرار دادن دیوار وجود ندارد",
                                          backgroundColor: Colors.red,
                                          colorText: Colors.white,
                                          icon: const Icon(
                                            Icons.warning_amber_rounded,
                                            color: Colors.white,
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                );
                              })),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Text("مسیر بهینه تا نقطه فعلی"),
                      const SizedBox(height: 10),
                      Container(
                        height: screenHeight * 0.35,
                        width: screenWidth * 0.2,
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
                                    borderRadius:
                                        calculateBorderRaduisForCorners(index),
                                  ),
                                  child: InkWell(
                                    customBorder: RoundedRectangleBorder(
                                      borderRadius:
                                          calculateBorderRaduisForCorners(
                                                  index) ??
                                              BorderRadius.circular(0),
                                    ),
                                    onTap: () {
                                      List<int> offset = indexToOffset(index);
                                      if (maze[offset[0]][offset[1]] == 0) {
                                        maze[offset[0]][offset[1]] = 1;
                                        setState(() {});
                                      } else {
                                        Get.snackbar(
                                          "خطا",
                                          "در نقطه شروع و نقطه هدف امکان قرار دادن دیوار وجود ندارد",
                                          backgroundColor: Colors.red,
                                          colorText: Colors.white,
                                          icon: const Icon(
                                            Icons.warning_amber_rounded,
                                            color: Colors.white,
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                );
                              })),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Row(
                    children: [
                      ColorGuide(title: "مسیر بهینه", color: Colors.orange),
                      ColorGuide(title: "خانه ناشناخته", color: Colors.grey),
                      ColorGuide(title: "هدف", color: Colors.green),
                      ColorGuide(title: "شروع", color: Colors.red),
                      ColorGuide(title: "دیوار", color: Colors.black),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: screenHeight * 0.7,
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
                                borderRadius:
                                    calculateBorderRaduisForCorners(index),
                              ),
                              child: InkWell(
                                customBorder: RoundedRectangleBorder(
                                  borderRadius:
                                      calculateBorderRaduisForCorners(index) ??
                                          BorderRadius.circular(0),
                                ),
                                onTap: () {
                                  List<int> offset = indexToOffset(index);
                                  if (maze[offset[0]][offset[1]] == 0) {
                                    maze[offset[0]][offset[1]] = 1;
                                    setState(() {});
                                  } else {
                                    Get.snackbar(
                                      "خطا",
                                      "در نقطه شروع و نقطه هدف امکان قرار دادن دیوار وجود ندارد",
                                      backgroundColor: Colors.red,
                                      colorText: Colors.white,
                                      icon: const Icon(
                                        Icons.warning_amber_rounded,
                                        color: Colors.white,
                                      ),
                                    );
                                  }
                                },
                              ),
                            );
                          })),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
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
        const SizedBox(width: 5),
        Text(title, style: TextStyle(color: color)),
        const SizedBox(width: 5),
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
