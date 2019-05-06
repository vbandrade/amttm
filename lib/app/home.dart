import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:amttm/app/time_counter_panel.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final style = TextStyle(fontSize: 24);
    return Scaffold(
      appBar: AppBar(
        title: Text('are men talking too much?'),
        backgroundColor: Colors.deepOrange[200],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            "who's talking?",
            style: style,
          ),
          TimerCounterPanel(["a dude", "not a dude"]),
          FlatButton(
            child: Text("inspired by:\nhttp://arementalkingtoomuch.com"),
            onPressed: _launchURL,
          )
        ],
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
