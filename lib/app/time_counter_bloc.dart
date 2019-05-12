import 'dart:async';
import 'package:flutter/material.dart';

class TimeCounterBloc with ChangeNotifier {
  final Map<String, Stopwatch> timerTable;
  bool isCounting = false;
  bool isStopped = true;
  Stream<int> currentPercentage;

  TimeCounterBloc(List<String> labels)
      : timerTable = labels.fold<Map<String, Stopwatch>>(
            Map<String, Stopwatch>(), _combineToMap) {
    currentPercentage = Stream<int>.periodic(
        Duration(milliseconds: 100), (x) => _calculatePercentage());
  }

  static Map<String, Stopwatch> _combineToMap(
      Map<String, Stopwatch> previousValue, String element) {
    previousValue[element] = Stopwatch();
    return previousValue;
  }

  int _calculatePercentage() {
    int percentage = 100;
    final menSW = timerTable["a dude"];
    final notMenSW = timerTable["not a dude"];
    if (!isStopped) isCounting = notMenSW.isRunning || menSW.isRunning;
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

  void start(String label) {
    timerTable.forEach((String s, Stopwatch sw) {
      sw.stop();
    });

    timerTable[label].start();
    isStopped = false;
    notifyListeners();
  }

  void stop() {
    timerTable.forEach((String s, Stopwatch sw) {
      sw.stop();
    });

    isStopped = true;
    notifyListeners();
  }

  void reset() {
    timerTable.forEach((String s, Stopwatch sw) {
      sw.stop();
      sw.reset();
    });

    isCounting = false;
    isStopped = true;
    notifyListeners();
  }
}
