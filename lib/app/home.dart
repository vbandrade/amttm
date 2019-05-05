import 'package:flutter/material.dart';
import 'package:amttm/app/time_counter.dart';

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
          TimerCounterPanel(["a dude", "not a dude"]),
        ],
      ),
    );
  }
}

class TimerCounterPanel extends StatefulWidget {
  final List<String> _labels;

  TimerCounterPanel(this._labels);

  @override
  _TimerCounterPanelState createState() => _TimerCounterPanelState();
}

class _TimerCounterPanelState extends State<TimerCounterPanel> {
  @override
  Widget build(BuildContext context) {
    List<TimeCounter> timers =
        widget._labels.map((label) => TimeCounter(label)).toList();

    return Row(
      children: timers,
    );
  }
}
