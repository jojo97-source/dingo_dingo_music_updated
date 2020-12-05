import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyRadioPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Dingo Dingo Radio'),
    ),
      body: Column(
        children: <Widget>[
          Image.asset('assets/radio-cassette-3634616_1280.png')
        ],
        ),


        drawer: Drawer(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children:<Widget> [
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
                      leading: Icon(Icons.my_library_music_rounded),
                      title: Text("Music Player"),
                    onTap: () => navigateToPage(context, 'home'),
                    ),
              ],
                    ),
                ),
    );
  }

  navigateToPage(BuildContext context, String page) {
    Navigator.of(context).pushNamedAndRemoveUntil(page, (Route<dynamic> route) => false);
  }
}