import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:amttm/app/time_counter_bloc.dart';
import 'package:amttm/app/time_counter_panel.dart';

class Home extends StatelessWidget {
  final labels = [Timers.aDude, Timers.notADude];

  @override
  Widget build(BuildContext context) {
    TimeCounterBloc _bloc = Provider.of<TimeCounterBloc>(context);

    var bottomText = RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: TextStyle(color: Colors.deepOrangeAccent[200]),
        children: <TextSpan>[
          TextSpan(
            text: 'inspired by\n',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
          TextSpan(text: 'http://arementalkingtoomuch.com'),
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('🤐 are men talking too much?'),
        backgroundColor: Colors.deepOrange[200],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            "who's talking?",
            style: TextStyle(fontSize: 24),
          ),
          TimeCounterPanel(labels, _bloc),
          FlatButton(
            child: bottomText,
            onPressed: _launchURL,
          ),
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
