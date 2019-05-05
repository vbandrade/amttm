import 'dart:async';

import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Are men talking too much?'),
      ),
      body: Column(
        children: <Widget>[
          Text("who's talking?"),
          Text("%"),
          Row(
            children: <Widget>[
              TimeCounter("a dude"),
              TimeCounter("not a dude"),
            ],
          )
        ],
      ),
    );
  }

  
}

class TimeCounter extends StatefulWidget {
  final Stopwatch _stopwatch = Stopwatch();
  final String _label;

  @override
  _TimeCounterState createState() => _TimeCounterState();

  TimeCounter(this._label);
}

class _TimeCounterState extends State<TimeCounter> {
  Duration _elapsedTime = Duration();

  void refreshTimerCallback(Timer timer) {
    setState(() {
      if (_elapsedTime == widget._stopwatch.elapsed) timer.cancel();
      _elapsedTime = widget._stopwatch.elapsed;
      debugPrint(_elapsedTime.inSeconds.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        RaisedButton(
          child: Text(widget._label),
          onPressed: (!widget._stopwatch.isRunning) ? _onPressed : null,
        ),
        Text("${_elapsedTime.inSeconds}"),
      ],
    );
  }

  void _onPressed() {
    widget._stopwatch.start();
    Timer.periodic(Duration(seconds: 1), refreshTimerCallback);
    debugPrint(widget._label);
  }

  void stopTimer() {
    widget._stopwatch.stop();
  }
}
