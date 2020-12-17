import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dingo_dingo_music/extend/channel.dart';
import 'package:dingo_dingo_music/extend/model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:dingo_dingo_music/extend/myPlayer.dart';


class MyRadioPage extends StatefulWidget {

  @override
  _MyRadioPageState createState() => _MyRadioPageState();
}

class _MyRadioPageState extends State<MyRadioPage> {
  List list;

  @override
  void initState() {
    super.initState();
    fetch();
  }

 fetch() async{
    list= getChannels();
    if(mounted)
      setState((){});
 }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<PlayerModel>(
        model: playerModel,
        child: Scaffold(
          body: list == null
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) => InkWell(
              onTap: () {
              Navigator.of(context).push(new MaterialPageRoute(
              builder: (context) => MyPlayer(list[index])));
              },
                    child: Card(
                    elevation: 3.0,
                  child: Column(
                  children: <Widget>[
                  AspectRatio(
                  aspectRatio: 18 / 11,
                  child: Image.network(list[index].imageurl,
                  fit: BoxFit.fill,
                   )),
                Text(list[index].title)
                ],
              ),
            ),
            ),
          ),
        ),
    );
  }
}