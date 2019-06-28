import 'package:amttm/app/time_counter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

typedef OnPressedCallback = void Function(Timers timer);

class TimeCounter extends StatelessWidget {
  final Timers timer;
  final String _label;
  final Stopwatch _stopwatch;
  final OnPressedCallback _onPressed;

  const TimeCounter(this.timer, this._stopwatch, this._onPressed)
      : this._label = timer == Timers.aDude ? "A Dude" : "Not a Dude";

  @override
  Widget build(BuildContext context) {
    final formater = NumberFormat("00", "BRL");
    final elapsedTime = _stopwatch.elapsed;
    final int minutes = elapsedTime.inMinutes ?? 0;
    final int seconds = (elapsedTime.inSeconds ?? 0) - (minutes * 60);
    return Column(
      children: <Widget>[
        RaisedButton(
          child: Text(_label),
          onPressed: (!_stopwatch.isRunning) ? () => _onPressed(timer) : null,
        ),
        Text("${formater.format(minutes)}:${formater.format(seconds)}"),
      ],
    );
  }
}
