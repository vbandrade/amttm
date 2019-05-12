import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:amttm/app/time_counter_bloc.dart';
import 'package:amttm/app/time_counter_panel.dart';

class Home extends StatelessWidget {
  final labels = ["a dude", "not a dude"];
  @override
  Widget build(BuildContext context) {
    final style = TextStyle(fontSize: 24);
    return ChangeNotifierProvider<TimeCounterBloc>(
      builder: (_) => TimeCounterBloc(labels),
      child: Scaffold(
        appBar: AppBar(
          title: Text('🤐 are men talking too much?'),
          backgroundColor: Colors.deepOrange[200],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              "who's talking?",
              style: style,
            ),
            TimeCounterPanel(labels),
            FlatButton(
              child: Text(
                "inspired by:\nhttp://arementalkingtoomuch.com",
                style: TextStyle(color: Colors.deepOrangeAccent[200]),
              ),
              onPressed: _launchURL,
            )
          ],
        ),
      ),
    );
  }

  void _launchURL() async {
    const url = 'http://arementalkingtoomuch.com';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'could not launch $url';
    }
  }
}
