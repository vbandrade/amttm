import 'package:flutter/material.dart';
import 'package:amttm/app/time_counter.dart';
import 'package:amttm/app/time_counter_bloc.dart';

class TimeCounterPanel extends StatelessWidget {
  final List<Timers> _timers;
  final TimeCounterBloc _bloc;

  TimeCounterPanel(this._timers, this._bloc);

  @override
  Widget build(BuildContext context) {

    List<TimeCounter> timers = _timers
        .map((label) => TimeCounter(
              label,
              _bloc.timerTable[label],
              _bloc.start,
            ))
        .toList();

    final style = TextStyle(fontSize: 24);

    return Column(
      children: <Widget>[
        StreamBuilder(
          stream: _bloc.currentPercentage,
          builder: (BuildContext context, AsyncSnapshot<int> percentage) {
            if (_bloc.isMeetingRunning && (percentage.hasData))
              return Text("${percentage.data}% men", style: style);
            return Text("", style: style);
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: timers,
        ),
        FlatButton.icon(
          icon: Icon(Icons.stop),
          label: Text("stop"),
          onPressed: _bloc.isMeetingRunning && !_bloc.allTimersAreStopped
              ? _bloc.stop
              : null,
        ),
        FlatButton.icon(
          icon: Icon(Icons.refresh),
          label: Text("reset"),
          onPressed: _bloc.isMeetingRunning ? _bloc.reset : null,
        )
      ],
    );
  }
}
