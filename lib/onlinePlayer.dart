import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:audio_manager/audio_manager.dart';
import 'package:dingo_dingo_music/extend/search_widget.dart';
import 'package:dingo_dingo_music/extend/browse_widget.dart';

class MyOnlinePlayer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyOnlinePlayerState();
  }
}

class MyOnlinePlayerState extends State<MyOnlinePlayer> {

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dingo Dingo Online Radio"),
      ),
      body: CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                   // ignore: deprecated_member_use
                   title:(Text('Search'))
              )],
           ),

          // ignore: missing_return
          tabBuilder: (context, index) {
            switch (index) {
              case 0:
                return CupertinoTabView(
                  builder: (context) => SearchWidget(),
                );
              case 0:
                return CupertinoTabView(
                  builder: (context) => BrowseWidget(),
                );
              case 1:
                return CupertinoTabView(
                  builder: (context) => SearchWidget(),
                );
              default:
                break;
            }
          },
      ),

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
                      leading: Icon(Icons.radio),
                      title: Text('Dingo Dingo Radio'),
                      onTap: () => navigateToPage(context, 'secondPage'),
                    ),
            ],
          ),
        ),
    );
  }
  String _formatDuration(Duration d) {
    if (d == null) return "--:--";
    int minute = d.inMinutes;
    int second = (d.inSeconds > 60) ? (d.inSeconds % 60) : d.inSeconds;
    String format = ((minute < 10) ? "0$minute" : "$minute") +
        ":" +
        ((second < 10) ? "0$second" : "$second");
    return format;
  }

  Widget songProgress(BuildContext context) {
    var style = TextStyle(color: Colors.black);
    return Row(
      children: <Widget>[
        Text(
          _formatDuration(audioManagerInstance.position),
          style: style,
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  trackHeight: 2,
                  thumbColor: Colors.tealAccent,
                  overlayColor: Colors.teal,
                  thumbShape: RoundSliderThumbShape(
                    disabledThumbRadius: 5,
                    enabledThumbRadius: 5,
                  ),
                  overlayShape: RoundSliderOverlayShape(
                    overlayRadius: 10,
                  ),
                  activeTrackColor: Colors.tealAccent,
                  inactiveTrackColor: Colors.grey,
                ),
                child: Slider(
                  value: _slider ?? 0,
                  onChanged: (value) {
                    setState(() {
                      _slider = value;
                    });
                  },
                  onChangeEnd: (value) {print(value);
                  if (audioManagerInstance.duration != null) {
                    Duration msec = Duration(
                        milliseconds:
                        (audioManagerInstance.duration.inMilliseconds *
                            value)
                            .round());
                    audioManagerInstance.seekTo(msec);
                  }
                  },
                )),
          ),
        ),
        Text(
          _formatDuration(audioManagerInstance.duration),
          style: style,
        ),
      ],
    );
  }

  Widget bottomPanel() {
    return Column(children: <Widget>[
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: songProgress(context),
      ),
      Container(
        padding: EdgeInsets.symmetric(vertical: 35),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            CircleAvatar(
              child: Center(
                child: IconButton(
                    icon: Icon(
                      Icons.skip_previous,
                      color: Colors.white,
                    ),
                    onPressed: () => audioManagerInstance.previous()),
              ),
              backgroundColor: Colors.cyan,
            ),
            CircleAvatar(
              radius: 30,
              child: Center(
                child: IconButton(
                  onPressed: () async {
                    if (audioManagerInstance.isPlaying)
                      audioManagerInstance.playOrPause();
                  },
                  padding: const EdgeInsets.all(0.0),
                  icon: Icon(
                    audioManagerInstance.isPlaying
                        ? Icons.pause
                        : Icons.play_arrow,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            CircleAvatar(
              backgroundColor: Colors.cyan,
              child: Center(
                child: IconButton(
                    icon: Icon(
                      Icons.skip_next,
                      color: Colors.white,
                    ),
                    onPressed: () => audioManagerInstance.next()),
              ),
            ),
          ],
        ),
      ),
    ]);
  }


  navigateToPage(BuildContext context, String page) {
    Navigator.of(context).pushNamedAndRemoveUntil(
        page, (Route<dynamic> route) => false);
  }

}

var audioManagerInstance = AudioManager.instance;
bool showVol = false;
PlayMode playMode = audioManagerInstance.playMode;
bool isPlaying = false;
double _slider;