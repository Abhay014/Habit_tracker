import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class HabitTile extends StatelessWidget {
  final String habitName;
  final VoidCallback ontap;
  final VoidCallback settingsTapped;
  final int timespent;
  final int timeGoal;
  final bool habitStarted;

  const HabitTile({
    Key? key,
    required this.habitName,
    required this.ontap,
    required this.settingsTapped,
    required this.timespent,
    required this.timeGoal,
    required this.habitStarted,
  }) : super(key: key);

  // convert sec into mins
  String formatToMinSec(int totalSeconds) {
    String secs = (totalSeconds % 60).toString();
    String mins = (totalSeconds / 60).toStringAsFixed(5);

    //if sec is 1 digit number add a0 infornt of it
    if (secs.length == 1) {
      secs = "0" + secs;
    }
    // if min is a ond digit n umber
    if (mins[1] == '.') {
      mins = mins.substring(0, 1);
    }
    return mins + ":" + secs;
  }

// calculate progress percentage
  double percentCompleted() {
    return timespent / (timeGoal * 60);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        padding: EdgeInsets.only(left: 20, right: 20, top: 20),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: ontap,
                  child: SizedBox(
                      height: 60,
                      width: 60,
                      child: Stack(
                        children: [
                          CircularPercentIndicator(
                            radius: 60,
                            percent:
                                percentCompleted() < 1 ? percentCompleted() : 1,
                            progressColor: percentCompleted() > 0.5
                                ? (percentCompleted() > 0.75
                                    ? Colors.green
                                    : Colors.orange)
                                : Colors.red,
                          ),
                          Center(
                              child: Icon(habitStarted
                                  ? Icons.pause
                                  : Icons.play_arrow))
                        ],
                      )),
                ),

                // progress circle
                // CircularPercentIndicator(
                //   radius: 40,
                // ),

                const SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // habit name
                    Text(
                      habitName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),

                    const SizedBox(
                      height: 4,
                    ),

                    // progress
                    Text(
                      formatToMinSec(timespent) +
                          '/' +
                          timeGoal.toString() +
                          "=" +
                          (percentCompleted() * 100).toStringAsFixed(0) +
                          "%",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
            GestureDetector(
              onTap: settingsTapped,
              child: Icon(Icons.settings),
            )
          ],
        ),
      ),
    );
  }
}
