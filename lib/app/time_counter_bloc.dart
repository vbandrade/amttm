import 'dart:async';
import 'package:flutter/material.dart';

enum Timers { aDude, notADude }

class TimeCounterBloc with ChangeNotifier {
  final timerTable = Map<Timers, Stopwatch>();
  //the current session is running, and reset hasnt been pressed
  bool isCounting = false;
  //determines if both timers are stopped
  bool isStopped = true;
  Stream<int> currentPercentage;

  TimeCounterBloc() {
    timerTable[Timers.aDude] = Stopwatch();
    timerTable[Timers.notADude] = Stopwatch();

    currentPercentage = Stream<int>.periodic(
        Duration(milliseconds: 100), (x) => _calculatePercentage());
  }

  int _calculatePercentage() {
    int percentage = 100;
    final menSW = timerTable[Timers.aDude];
    final notMenSW = timerTable[Timers.notADude];

    if (isCounting) {
      percentage = ((menSW.elapsedMilliseconds /
                  (menSW.elapsedMilliseconds + notMenSW.elapsedMilliseconds)) *
              100)
          .toInt();
      if (notMenSW.elapsedMilliseconds == 0) percentage = 100;
    } else {
      percentage = 100;
    }

    notifyListeners();
    return percentage;
  }

  void start(Timers timer) {
    timerTable.forEach((Timers s, Stopwatch sw) {
      sw.stop();
    });
    timerTable[timer].start();
    isStopped = false;
    isCounting = true;

    notifyListeners();
  }

  void stop() {
    timerTable.forEach((Timers s, Stopwatch sw) {
      sw.stop();
    });
    isStopped = true;
    isCounting = true;

    notifyListeners();
  }

  void reset() {
    timerTable.forEach((Timers s, Stopwatch sw) {
      sw.stop();
      sw.reset();
    });
    isCounting = false;
    isStopped = true;

    notifyListeners();
  }
}
