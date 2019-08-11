import 'package:amttm/app/time_counter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:amttm/app/home.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'are men talking too much?',
        home: ChangeNotifierProvider<TimeCounterBloc>(
          builder: (_) => TimeCounterBloc(),
          child: Home(),
        ));
  }
}
