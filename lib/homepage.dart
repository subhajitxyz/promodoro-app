// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:pomodoro/breakpage.dart';
import 'package:wheel_chooser/wheel_chooser.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int focusTime = 25;
  bool isRunning = false;
  // Duration remainingTime = const Duration(seconds: 10);
  Duration remainingTime = const Duration(minutes: 25);
  Timer? timer;
  int breakTime = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text(
      //     'POMODORO',
      //     style: TextStyle(
      //       color: Colors.white,
      //       fontSize: 30,
      //       fontFamily: 'Digital',
      //     ),
      //   ),
      //   centerTitle: true,
      //   backgroundColor: Colors.red,
      // ),
      backgroundColor: Colors.red,
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 40),
          // focus time selector
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  const Text(
                    'Focus Time',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontFamily: 'monospace',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Card(
                    elevation: 20,
                    child: Container(
                      height: 200,
                      width: 120,
                      padding: EdgeInsets.all(30),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.red,
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                      ),
                      child: WheelChooser.integer(
                        onValueChanged: (value) {
                          focusTime = value;
                        },
                        maxValue: 60,
                        minValue: 25,
                        initValue: 25,
                        step: 5,
                        unSelectTextStyle:
                            TextStyle(color: Colors.grey.shade800),
                        selectTextStyle: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      isRunning = false;
                      remainingTime = Duration(minutes: focusTime);
                      timer?.cancel();
                      setState(() {});
                    },
                    child: Card(
                      elevation: 20,
                      child: Container(
                        width: 120,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          "Set",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 20),
              Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  const Icon(
                    Icons.coffee_outlined,
                    color: Colors.white,
                    size: 40,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Card(
                    elevation: 20,
                    child: Container(
                      height: 200,
                      width: 120,
                      padding: EdgeInsets.all(30),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.red,
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                      ),
                      child: WheelChooser.integer(
                        onValueChanged: (value) {
                          breakTime = value;
                        },
                        maxValue: 20,
                        minValue: 5,
                        initValue: 5,
                        step: 5,
                        unSelectTextStyle:
                            TextStyle(color: Colors.grey.shade800),
                        selectTextStyle: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Break Time',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 10),

          // timer
          Text(
            durationToTimeString(remainingTime),
            style: const TextStyle(
              fontSize: 100,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'monospace',
            ),
          ),
          // const SizedBox(height: 5),
          Card(
            elevation: 10,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: LinearProgressIndicator(
                value: remainingTime.inSeconds / (focusTime * 60),
                color: Colors.white,
                backgroundColor: Colors.grey.shade500,
                minHeight: 10,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),

          const SizedBox(height: 40),

          // buttons
          GestureDetector(
            onTap: () {
              if (isRunning) {
                if (timer != null) {
                  timer!.cancel();
                }
                isRunning = false;
                setState(() {});
                return;
              }
              isRunning = true;
              timer = Timer.periodic(
                const Duration(seconds: 1),
                (timer) async {
                  if (remainingTime.inSeconds == 6) {
                    startCountDown();
                  }
                  if (remainingTime.inSeconds == 0) {
                    timer.cancel();
                    isRunning = false;
                    bool? isBreak = await showDialog(
                      context: context,
                      builder: (context) {
                        return const MyAlertDialog();
                      },
                    );
                    if (isBreak == null || isBreak == false) {
                      remainingTime = Duration(minutes: focusTime);
                      setState(() {});
                      return;
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return BreakPage(
                            breakTimeArg: breakTime,
                          );
                        },
                      ),
                    );
                    remainingTime = Duration(minutes: focusTime);
                  } else {
                    remainingTime -= const Duration(seconds: 1);
                  }
                  setState(() {});
                },
              );
              setState(() {});
            },
            child: Card(
              elevation: 20,
              child: Container(
                width: 200,
                height: 100,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.red,
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Start",
                      style: TextStyle(
                        fontSize: 25,
                        // fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    // const SizedBox(width: 5),
                    Icon(
                      isRunning ? Icons.pause : Icons.play_arrow,
                      color: Colors.white,
                      size: 35,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

String durationToTimeString(Duration currentTime) {
  String seconds =
      currentTime.inSeconds.remainder(60).toString().padLeft(2, '0');
  String minutes = currentTime.inMinutes.toString().padLeft(2, '0');
  return '$minutes:$seconds';
}

void startCountDown() {
  final AudioPlayer audioPlayer = AudioPlayer();
  Duration duration = const Duration(seconds: 5);
  audioPlayer.play(AssetSource('timer_end.wav'));
  Timer(
    duration,
    () {
      audioPlayer.stop();
    },
  );
}

class MyAlertDialog extends StatelessWidget {
  const MyAlertDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey.shade300,
      title: const Text(
        'Time is up!',
        style: TextStyle(
          fontFamily: 'monospace',
        ),
      ),
      content: const Text(
        'Do you want to take a break?',
        style: TextStyle(
          fontFamily: 'monospace',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          style: TextButton.styleFrom(
            foregroundColor: Colors.grey.shade600,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          child: const Text(
            "Take Break!",
            style: TextStyle(
              color: Colors.blue,
              fontFamily: 'monospace',
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          style: TextButton.styleFrom(
            foregroundColor: Colors.grey.shade600,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          child: const Text(
            "Focus Again!",
            style: TextStyle(
              color: Colors.blue,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    );
  }
}
