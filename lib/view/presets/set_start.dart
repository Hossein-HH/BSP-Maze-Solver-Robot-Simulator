import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/utils.dart';

class SetStart extends StatelessWidget {
  const SetStart({super.key});

  @override
  Widget build(BuildContext context) {
    calculateScreenSize(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Container(
          alignment: Alignment.centerRight,
          child:
              const Text("تعیین نقطه شروع", style: TextStyle(color: Colors.black54)),
        ),
      ),
      body: Column(
        children: [
          const Expanded(
              flex: 1,
              child: Center(child: Text("نقطه‌ی شروع ربات را مشخص کنید"))),
          // a GridView with 10x10 cells
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
                            botMaze[offset[0]][offset[1]] = 0;
                            maze[offset[0]][offset[1]] = -2;
                            Get.offNamed('/setGoal');
                          },
                          child: Center(child: Text(index.toString())),
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
