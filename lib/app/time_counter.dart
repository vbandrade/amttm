import 'dart:async';
import 'package:flutter/material.dart';

class TimeCounter extends StatefulWidget {
  final Stopwatch _stopwatch = Stopwatch();
  final String _label;

  @override
  _TimeCounterState createState() => _TimeCounterState();

  TimeCounter(this._label);
}

class _TimeCounterState extends State<TimeCounter> {
  Duration _elapsedTime = Duration();
  Timer _timer;

  void refreshTimerCallback(Timer timer) {
    if (_elapsedTime == widget._stopwatch.elapsed) {
      timer.cancel();
    } else {
      setState(() {
        _elapsedTime = widget._stopwatch.elapsed;
        debugPrint(_elapsedTime.inSeconds.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final int minutes = _elapsedTime.inMinutes;
    final int seconds = _elapsedTime.inSeconds - (minutes * 60);
    return Column(
      children: <Widget>[
        RaisedButton(
          child: Text(widget._label),
          onPressed: (!widget._stopwatch.isRunning) ? _onPressed : null,
        ),
        Text("$minutes:$seconds"),
      ],
    );
  }

  void _onPressed() {
    widget._stopwatch.start();
    _timer = Timer.periodic(Duration(milliseconds: 400), refreshTimerCallback);
    debugPrint(widget._label);
  }

  void stopTimer() {
    widget._stopwatch.stop();
  }

  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
