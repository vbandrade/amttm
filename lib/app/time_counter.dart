import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

typedef OnPressedCallback = void Function(String label);

class TimeCounter extends StatelessWidget {
  final String _label;
  final Stopwatch _stopwatch;
  final OnPressedCallback _onPressed;

  const TimeCounter(this._label, this._stopwatch, this._onPressed);

  @override
  Widget build(BuildContext context) {
    NumberFormat formater = NumberFormat("00");
    final elapsedTime = _stopwatch.elapsed;
    final int minutes = elapsedTime.inMinutes ?? 0;
    final int seconds = (elapsedTime.inSeconds ?? 0) - (minutes * 60);
    return Column(
      children: <Widget>[
        RaisedButton(
          child: Text(_label),
          onPressed: (!_stopwatch.isRunning) ? () => _onPressed(_label) : null,
        ),
        Text("${formater.format(minutes)}:${formater.format(seconds)}"),
      ],
    );
  }
}
