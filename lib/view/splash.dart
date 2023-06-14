import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../utils/utils.dart';

class Splash extends StatelessWidget {
  Splash({super.key}) {
    Future.delayed(const Duration(seconds: 3), () {
      Get.offNamed('/setStart');
    });
  }

  @override
  Widget build(BuildContext context) {
    calculateScreenSize(context);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              'شبیه‌ساز ربات حل ماز',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
                fontSize: 24,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(bottom: screenHeight * 0.1),
              height: screenHeight * 0.15,
              alignment: Alignment.bottomCenter,
              child: Lottie.asset(
                'assets/gifs/loading.json',
              ),
            ),
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
