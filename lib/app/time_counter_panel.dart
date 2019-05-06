import 'dart:async';
import 'package:flutter/material.dart';
import 'package:amttm/app/time_counter.dart';

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
    _timer = Timer.periodic(Duration(seconds: 1), _refreshTimerCallback);
  }

  @override
  Widget build(BuildContext context) {
    _calculatePercentage();
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
        FlatButton.icon(
          icon: Icon(Icons.refresh),
          label: Text("reset"),
          onPressed: _displayPercentage ? _reset : null,
        )
      ],
    );
  }

  void _refreshTimerCallback(Timer timer) {
    setState(() {
      _calculatePercentage();
    });
  }

  void _calculatePercentage() {
    final menSW = widget._timerTable["a dude"];
    final notMenSW = widget._timerTable["not a dude"];
    _displayPercentage = notMenSW.isRunning || menSW.isRunning;
    if (_displayPercentage) {
      _percentage = ((menSW.elapsedMilliseconds /
                  (menSW.elapsedMilliseconds + notMenSW.elapsedMilliseconds)) *
              100)
          .toInt();
    } else {
      _percentage = 100;
    }
    debugPrint(_percentage.toString());
  }

  void _onPressed(String label) {
    widget._timerTable.forEach((String s, Stopwatch sw) {
      sw.stop();
    });
    setState(() {
      _calculatePercentage();
    });
  }

  void _reset() {
    widget._timerTable.forEach((String s, Stopwatch sw) {
      sw.stop();
      sw.reset();
    });
  }

  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
