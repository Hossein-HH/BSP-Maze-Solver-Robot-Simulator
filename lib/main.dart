import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'view/presets/set_goal.dart';
import 'view/presets/set_start.dart';
import 'view/presets/set_walls.dart';
import 'view/splash.dart';
import 'view/home.dart';

void main() {
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      getPages: [
        GetPage(name: '/splash', page: () => Splash()),
        GetPage(name: '/setStart', page: () => const SetStart()),
        GetPage(name: '/setGoal', page: () => const SetGoal()),
        GetPage(name: '/setWalls', page: () => const SetWalls()),
        GetPage(name: '/home', page: () => Home()),
      ],
      theme: ThemeData(
        fontFamily: "IRANSansX",
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    ),
  );
}
