import 'dart:io';
import 'package:dingo_dingo_music/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:dingo_dingo_music/widget.dart';

class SongWidget extends StatelessWidget {
  final List<SongInfo> songList;

  SongWidget({@required this.songList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: songList.length,
        itemBuilder: (context, songIndex) {
          SongInfo song = songList[songIndex];
          if (song.displayName.contains(".mp3")) {
            return Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    ClipRRect(
                      child: Image(
                        image: AssetImage("assets/music-player-2939936_640.jpg") ?? FileImage(File(song.albumArtwork)),
                        height: 90,
                        width: 150,
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: Text(song.title,
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700)),
                              ),
                              Text("Release Year: ${song.year}",
                                  style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500)),
                              Text("Artist: ${song.artist}",
                                  style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500)),
                              Text("Composer: ${song.composer}",
                                  style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500)),
                              Text(
                                  "Duration: ${parseToMinutesSeconds(int.parse(song.duration))} min",
                                  style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500)),
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              audioManagerInstance
                                  .start("file://${song.filePath}", song.title,
                                  desc: song.displayName,
                                  auto: true,
                                  cover:('assets/headsets-1971383_1280.jpg') ??(song.albumArtwork))
                                  .then((err) {
                                print(err);
                              });
                            },

                            child: IconText(
                              iconData: Icons.play_circle_outline,
                              iconColor: Colors.teal,
                              string: "Play",
                              textColor: Colors.black,
                              iconSize: 25,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return SizedBox(
            height: 0,
          );
        });
  }

  static String parseToMinutesSeconds(int ms) {
    String data;
    Duration duration = Duration(milliseconds: ms);

    int minutes = duration.inMinutes;
    int seconds = (duration.inSeconds) - (minutes * 60);

    data = minutes.toString() + ":";
    if (seconds <= 9) data += "0";

    data += seconds.toString();
    return data;

  }

}