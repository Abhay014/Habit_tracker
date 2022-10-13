import 'dart:async';

import 'package:flutter/material.dart';
import 'package:habit_tracker/util/habit_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
// over all habit summary
  List habitList = [
    ['exercise', false, 0, 10],
    ['meditate', false, 0, 20],
    ['code', false, 0, 40],
    ['read', false, 0, 20],
  ];
  void habitStarted(int index) {
    var startTime = DateTime.now();
    setState(() {
      habitList[index][1] = !habitList[index][1];
    });

    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (!habitList[index][1]) {
          timer.cancel();
        }

        var currentTime = DateTime.now();
        habitList[index][2] = currentTime.second - startTime.second;
      });
    });
  }

  void settingsOpened(int index) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("settings for " + habitList[index][0]),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: Text("consistency is key"),
        centerTitle: false,
      ),
      body: ListView.builder(
          itemCount: habitList.length,
          itemBuilder: ((context, index) {
            return HabitTile(
              habitName: habitList[index][0],
              ontap: () {
                habitStarted(index);
              },
              settingsTapped: () {
                settingsOpened(index);
              },
              habitStarted: habitList[index][1],
              timespent: habitList[index][2],
              timeGoal: habitList[index][3],
            );
          })),
    );
  }
}
