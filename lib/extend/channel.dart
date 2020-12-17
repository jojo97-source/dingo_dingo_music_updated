import 'package:dingo_dingo_music/extend/model.dart';

class Channel{
  String url;
  String title;
  String genre;
  int rank;
  String imageurl;

  Channel({this.title,this.url,this.genre,this.imageurl});

  factory Channel.fromJson(Map<String, dynamic> parsedJson){
    return Channel(title:parsedJson['title'].toString(), url:parsedJson['url'], genre:parsedJson['type'].toString(),imageurl:parsedJson['imgurl'].toString());
  }
  static getCategories(List<Channel> list){
    return Set.from(list.map((ch)=>ch.genre)).toList();
  }
}
List getChannels()  {
  return [
    Channel(
      title:"ZIP 103 FM",
        url:"http://ec2-52-205-111-133.compute-1.amazonaws.com:9448/;stream.mp3",
        imageurl:"https://cdn.webrad.io/images/logos/jamaicaradio-net/zip.png"),

    Channel(title:"IndieXL Online Radio",
        url:"http://server-23.stream-server.nl:8438",
        imageurl: "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSMd4s3oWzzUvWBM_7L54w5_qduRsvThX3vChcnC3eGj1BoZc8Q&usqp=CAU"),
    Channel(
        title:"Desi Music Mix!",
        url:"http://158.69.161.125:8012/?type=http&nocache=57533",
        imageurl:"https://mytuner.global.ssl.fastly.net/media/tvos_radios/Typgmp8Z8D.png"),
    Channel(
        url:"http://5.196.56.208:8308/stream",
        title: "Hindi Music Radio - anytime, anywere",
        imageurl: "https://images-na.ssl-images-amazon.com/images/I/51WSc%2BN-5CL._SY355_.png"),
  Channel(
      title:"Mehfil Radio",
      url:"http://mehefil.no-ip.com/mehefil",
      imageurl: "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSMd4s3oWzzUvWBM_7L54w5_qduRsvThX3vChcnC3eGj1BoZc8Q&usqp=CAU"
  ),
  Channel(
      url:"http://176.31.107.8:8459/stream",
      title: "Radio Central",
      imageurl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ4X8tigdkbQtr7R7U2Vesifoo7_e3sGsk_wBV7GqEgBNZfZPA&s")


  ];
}


Channel currentCh=getChannels()[0];
PlayerModel playerModel=PlayerModel();

