import 'dart:async';
import 'package:flutter/material.dart';

class TimeCounterBloc with ChangeNotifier {
  final Map<String, Stopwatch> timerTable;
  int percentage = 100;
  bool isCounting = false;
  bool isStopped = true;
  Timer _timer;

  TimeCounterBloc(List<String> labels)
      : timerTable = labels.fold<Map<String, Stopwatch>>(
            Map<String, Stopwatch>(), _combineToMap) {
    _timer = Timer.periodic(Duration(milliseconds: 100), _refreshTimerCallback);
  }

  static Map<String, Stopwatch> _combineToMap(
      Map<String, Stopwatch> previousValue, String element) {
    previousValue[element] = Stopwatch();
    return previousValue;
  }

  void _refreshTimerCallback(Timer timer) {
    _calculatePercentage();
  }

  void _calculatePercentage() {
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
  }

  void start(String label) {
    timerTable.forEach((String s, Stopwatch sw) {
      sw.stop();
    });
    timerTable[label].start();
    isStopped = false;
    _calculatePercentage();
  }

  void stop() {
    timerTable.forEach((String s, Stopwatch sw) {
      sw.stop();
    });
    isStopped = true;
    _calculatePercentage();
  }

  void reset() {
    timerTable.forEach((String s, Stopwatch sw) {
      sw.stop();
      sw.reset();
    });
    isCounting = false;
    isStopped = true;
    percentage = 100;
    _calculatePercentage();
  }

  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
