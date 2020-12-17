import 'package:flutter/material.dart';
import 'package:dingo_dingo_music/radioPlay.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:audio_manager/audio_manager.dart';
import 'package:dingo_dingo_music/songWidget.dart';
import 'package:dingo_dingo_music/widget.dart';
import 'package:dingo_dingo_music/onlinePlayer.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dingo Dingo Music Player',
      theme: ThemeData(
        primaryColor: Colors.tealAccent,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
          bodyText1: TextStyle(),).apply(
          bodyColor:Colors.black
        )
      ),
      routes: {
        'home':(context) => MyHomePage(),
        'secondPage': (context) => MyRadioPlay(),
        'thirdPage': (context) => MyOnlinePlayer(),
      },
      initialRoute: 'home',
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    setupAudio();
  }



  void setupAudio() {
    audioManagerInstance.onEvents((events, args) {
      switch (events) {
        case
        AudioManagerEvents.start:
          _slider = 0;
          break;
        case
        AudioManagerEvents.seekComplete:
          _slider = audioManagerInstance.position.inMilliseconds /
              audioManagerInstance.duration.inMilliseconds;
          setState(() {});
          break;
        case
        AudioManagerEvents.playstatus:
          isPlaying = audioManagerInstance.isPlaying;
          setState(() {});
          break;
        case
        AudioManagerEvents.timeupdate:
          _slider = audioManagerInstance.position.inMilliseconds /
              audioManagerInstance.duration.inMilliseconds;
          audioManagerInstance.updateLrc(args["position"].toString());
          setState(() {});
          break;
        case
        AudioManagerEvents.ended:
          audioManagerInstance.next();
          setState(() {});
          break;
        default:
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      showVol = !showVol;
                    });
                  },
                  child: IconText(
                      textColor: Colors.black,
                      iconColor: Colors.black,
                      string: "Volume",
                      iconSize: 20,
                      iconData: Icons.volume_down),
                ),
              )
            ],
            elevation: 0,
            backgroundColor: Colors.tealAccent,
            title: showVol
                ? Slider(
              value: audioManagerInstance.volume ?? 0,
              onChanged: (value) {
                setState(() {
                  audioManagerInstance.setVolume(value, showVolume: true);
                });
              },
            )
                : Text('Dingo Dingo Music Player',
                  style:TextStyle(color: Colors.black)),
          ),

          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                height: 500,
                child: FutureBuilder(
                  future: FlutterAudioQuery().getSongs(
                      sortType: SongSortType.RECENT_YEAR),
                  builder: (context, snapshot) {
                    List<SongInfo> songInfo = snapshot.data;
                    if (snapshot.hasData)
                      return SongWidget(songList: songInfo);

                    return Container(
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.2,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            CircularProgressIndicator(),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "Loading....",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
          ),
              bottomPanel(),
            ],
          ),


          //Side menu
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
                  leading: Icon(Icons.radio),
                  title: Text('Dingo Dingo Radio'),
                  onTap: () => navigateToPage(context, 'secondPage'),
                ),
                ListTile(
                  leading: Icon(Icons.music_note),
                  title: Text('Dingo Dingo Online Player'),
                  onTap: () => navigateToPage(context, 'thirdPage'),
                ),
              ],
            ),
          )
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


