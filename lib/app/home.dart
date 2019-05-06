import 'dart:async';

import 'package:flutter/material.dart';
import 'package:amttm/app/time_counter.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final style = TextStyle(fontSize: 24);
    return Scaffold(
      appBar: AppBar(
        title: Text('Are men talking too much?'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            "who's talking?",
            style: style,
          ),
          TimerCounterPanel(["a dude", "not a dude"]),
        ],
      ),
    );
  }
}

class TimerCounterPanel extends StatefulWidget {
  final List<String> _labels;
  final Map<String, Stopwatch> _timerTable;

  TimerCounterPanel(this._labels)
      : _timerTable = _labels.fold<Map<String, Stopwatch>>(
            Map<String, Stopwatch>(), combine);

  static Map<String, Stopwatch> combine(
      Map<String, Stopwatch> previousValue, String element) {
    previousValue[element] = Stopwatch();
    return previousValue;
  }

  @override
  _TimerCounterPanelState createState() => _TimerCounterPanelState();
}

class _TimerCounterPanelState extends State<TimerCounterPanel> {
  int _percentage = 100;
  bool _displayPercentage = false;
  Timer _timer;

  _TimerCounterPanelState() {
    _timer = Timer.periodic(Duration(seconds: 1), refreshTimerCallback);
  }

  @override
  Widget build(BuildContext context) {
    calculatePercentage();
    List<TimeCounter> timers = widget._labels
        .map((label) => TimeCounter(
              label,
              widget._timerTable[label],
              _onPressed,
            ))
        .toList();

    final style = TextStyle(fontSize: 24);

    return Column(
      children: <Widget>[
        Container(
          child: _displayPercentage
              ? Text("$_percentage% men", style: style)
              : Text("", style: style),
          margin: EdgeInsets.only(bottom: 20),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: timers,
        ),
      ],
    );
  }

  void refreshTimerCallback(Timer timer) {
    setState(() {
      calculatePercentage();
    });
  }

  void calculatePercentage() {
    final menSW = widget._timerTable["a dude"];
    final notMenSW = widget._timerTable["not a dude"];
    _displayPercentage = notMenSW.isRunning || menSW.isRunning;
    if (_displayPercentage) {
      _percentage = ((menSW.elapsedMilliseconds /
                  (menSW.elapsedMilliseconds + notMenSW.elapsedMilliseconds)) *
              100)
          .toInt();
      debugPrint(_percentage.toString());
    }
  }

  void _onPressed(String label) {
    widget._timerTable.forEach((String s, Stopwatch sw) {
      sw.stop();
    });
    setState(() {
      calculatePercentage();
    });
  }

  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
