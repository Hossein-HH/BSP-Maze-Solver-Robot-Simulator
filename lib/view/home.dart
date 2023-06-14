import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: Container(
        alignment: Alignment.centerRight,
        child: const Text("ساخت ماز", style: TextStyle(color: Colors.black54)),
      ),
    ));
  }
}
