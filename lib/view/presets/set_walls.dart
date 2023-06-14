import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/utils.dart';

class SetWalls extends StatefulWidget {
  const SetWalls({super.key});

  @override
  State<SetWalls> createState() => _SetWallsState();
}

class _SetWallsState extends State<SetWalls> {
  @override
  Widget build(BuildContext context) {
    calculateScreenSize(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Container(
          alignment: Alignment.centerRight,
          child:
              const Text("ایجاد مانع", style: TextStyle(color: Colors.black54)),
        ),
        leading: IconButton(
          icon: const Icon(Icons.check, color: Colors.black54),
          onPressed: () {
            Get.offNamed("/home");
          },
        ),
      ),
      body: Column(
        children: [
          const Expanded(
              flex: 1, child: Center(child: Text("دیوارها را مشخص کنید"))),
          Expanded(
            flex: 9,
            child: Container(
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
                          color: getCellsColor(index),
                          border: calculateBorderForCells(index),
                          borderRadius: calculateBorderRaduisForCorners(index),
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
          ),
        ],
      ),
    );
  }
}
