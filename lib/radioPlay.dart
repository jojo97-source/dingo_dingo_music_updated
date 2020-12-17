import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_radio/flutter_radio.dart';
import 'package:dingo_dingo_music/radio.dart';


class MyRadioPlay extends StatefulWidget {
@override
State<StatefulWidget> createState() {
  return MyRadioPlayState();
  }
}

class MyRadioPlayState extends State<MyRadioPlay> {

  @override
  void initState() {
    super.initState();
      audioStart();
  }

  Future<void> audioStart() async {
    await FlutterRadio.audioStart();
    print('Let The Radio Begin...');
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (Platform.isAndroid) {
          if (Navigator.of(context).canPop()) {
            return Future.value(true);
          }
          else {
            return Future.value(false);
          }
        }
        else {
          return Future.value(true);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Dingo Dingo Radio"),
        ),
        body: MyRadioPage(),

        drawer: Drawer(
          child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.tealAccent,
              ),
              child: Text(
                'Dingo Dingo Menu',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.library_music_rounded),
              title: Text('Dingo Dingo Music Player'),
              onTap: () => navigateToPage(context, 'home'),
            ),
            ListTile(
              leading: Icon(Icons.music_note),
              title: Text('Dingo Dingo Online Player'),
              onTap: () => navigateToPage(context, 'thirdPage'),
            ),
          ],
          ),
      ),
      ),
    );
  }

    navigateToPage(BuildContext context, String page) {
      Navigator.of(context).pushNamedAndRemoveUntil(
          page, (Route<dynamic> route) => false);
    }
  }