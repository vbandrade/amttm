import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:amttm/app/time_counter.dart';
import 'package:amttm/app/time_counter_bloc.dart';

class TimeCounterPanel extends StatelessWidget {
  final List<Timers> _timers;

  TimeCounterPanel(this._timers);

  @override
  Widget build(BuildContext context) {
    TimeCounterBloc _bloc = Provider.of<TimeCounterBloc>(context);
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
            if (_bloc.isCounting && (percentage.hasData))
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
          onPressed: _bloc.isCounting && !_bloc.isStopped ? _bloc.stop : null,
        ),
        FlatButton.icon(
          icon: Icon(Icons.refresh),
          label: Text("reset"),
          onPressed: _bloc.isCounting ? _bloc.reset : null,
        )
      ],
    );
  }
}
