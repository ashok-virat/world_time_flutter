import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  String time = 'loading';

  void setWorldTime() async{
    WorldTime instance = WorldTime(location: 'Asia', flag: 'berlin.jpg', url: 'Asia/Kolkata');
   await instance.getTime();
   Navigator.pushReplacementNamed(context, '/home',arguments: {
     'location':instance.location,
     'flag':instance.flag,
     'time':instance.time,
     'isDayTime':instance.isDayTime
   });
  }

  @override
  void initState(){
    // TODO: implement
    super.initState();
    setWorldTime();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: Center(
          child: SpinKitFadingCube(
            color: Colors.white,
            size: 80.0,
          ),
      ),
    );
  }
}

