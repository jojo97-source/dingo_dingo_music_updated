import 'package:flutter/material.dart';
import 'package:flutter_radio/flutter_radio.dart';
import 'package:dingo_dingo_music/extend/model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:dingo_dingo_music/extend/channel.dart';
import 'package:flutter/widgets.dart';


class MyPlayer extends StatefulWidget {
  Channel channel;
  MyPlayer(this.channel);
  @override
  _MyPlayerState createState() => new _MyPlayerState();
}


class _MyPlayerState extends State<MyPlayer> {
  String url;
  //Audio audio;

  @override
  initState() {
    super.initState();

    url = widget.channel.url;

    audioStart();

  }

  audioStart() async {

    if (await FlutterRadio.isPlaying()) {
      if (url != currentCh.url) {
        FlutterRadio.stop();
        FlutterRadio.play(url: url);
      } else {}
    } else {
      print("You See This?");
      FlutterRadio.playOrPause(url: url);
    }
    playingStatus();
    currentCh = widget.channel;
    print('Coming Alive...');
  }

  Future playingStatus() async {

    playerModel.update(true);

  }

  @override
  void dispose() {
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: new ScopedModel<PlayerModel>(
        model: playerModel,
        child: Scaffold(
          backgroundColor: Colors.teal,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ScopedModelDescendant<PlayerModel>(
                builder: (context, child, model) => new Container(
                  height: MediaQuery.of(context).size.height / 1.8,
                  width: MediaQuery.of(context).size.width,
                  child: Hero(
                    tag: "1234",
                    child: Image.asset("assets/radio-cassette-3634616_1280.png"),
                    ),
                  ),
                ),
              Hero(tag:"title",
                  child: Text(widget.channel.title,style: TextStyle(color:Colors.white),)),
              new ScopedModelDescendant<PlayerModel>(
                builder: (context, child, model) => FloatingActionButton(

                    backgroundColor: Colors.teal,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        model.isPlaying?Icons.pause:Icons.play_arrow,
                        color: Colors.tealAccent,
                        size: 35.0,
                      ),
                    ),
                    onPressed: ()async{
                      FlutterRadio.playOrPause(url: url);
                      model.update(null);
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  onPressed() {
    print("Playing?");
    FlutterRadio.playOrPause(url: url);

  }
}