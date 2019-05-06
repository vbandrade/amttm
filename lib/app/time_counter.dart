import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

typedef OnPressedCallback = void Function(String label);

class TimeCounter extends StatefulWidget {
  final Stopwatch _stopwatch;
  final String _label;
  final OnPressedCallback _onPressed;

  @override
  _TimeCounterState createState() => _TimeCounterState();

  TimeCounter(this._label, this._stopwatch, this._onPressed);
}

class _TimeCounterState extends State<TimeCounter> {
  Duration _elapsedTime = Duration();
  Timer _timer;
  NumberFormat formater = NumberFormat("00");

  void refreshTimerCallback(Timer timer) {
    if (_elapsedTime == widget._stopwatch.elapsed) {
      timer.cancel();
    } else {
      setState(() {
        _elapsedTime = widget._stopwatch.elapsed;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final int minutes = _elapsedTime.inMinutes ?? 0;
    final int seconds = (_elapsedTime.inSeconds ?? 0) - (minutes * 60);
    return Column(
      children: <Widget>[
        RaisedButton(
          child: Text(widget._label),
          onPressed: (!widget._stopwatch.isRunning) ? _onPressed : null,
        ),
        Text("${formater.format(minutes)}:${formater.format(seconds)}"),
      ],
    );
  }

  void _onPressed() {
    widget._onPressed(widget._label);
    widget._stopwatch.start();
    _timer = Timer.periodic(Duration(milliseconds: 400), refreshTimerCallback);
  }

  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
