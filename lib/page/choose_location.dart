import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({super.key});

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {

  bool loading = false;

  List<WorldTime> locations = [
    WorldTime( location: 'London',url: 'Europe/London', flag: 'uk.png'),
    WorldTime(location: 'Athens',url: 'Europe/Berlin', flag: 'Greece..png'),
    WorldTime( location: 'Cairo',url: 'Africa/Cairo', flag: 'egypt.png'),
    WorldTime(url: 'Africa/Nairobi', location: 'Nairobi', flag: 'Kenya.png'),
    WorldTime(url: 'America/Chicago', location: 'Chicago', flag: 'usa.png'),
    WorldTime(url: 'America/New_York', location: 'New York', flag: 'usa.png'),
    WorldTime(url: 'Asia/Seoul', location: 'Seoul', flag: 'sk.png'),
    WorldTime(url: 'Asia/Jakarta', location: 'Jakarta', flag: 'indonesia.png'),
  ];

  void updateTime(index) async{
     WorldTime instance = locations[index];
     setState(() {
       loading = true;
     });
     await instance.getTime();
     setState(() {
       loading = false;
     });
       Navigator.pop(context,{
       'location':instance.location,
       'flag':instance.flag,
       'time':instance.time,
       'isDayTime':instance.isDayTime
     });
  }

  @override
  Widget build(BuildContext context) {
    if(!loading){
     return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colors.blue[900],
          title: Text('Choose Location'),
          centerTitle: true,
        ),
        body: ListView.builder(
            itemCount: locations.length,
            itemBuilder: (context,index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 1,horizontal: 4),
                child: Card(
                  child: ListTile(
                    onTap: () {
                      updateTime(index);
                    },
                    title: Text(locations[index].location),
                    leading: CircleAvatar(
                      backgroundImage: AssetImage('assets/${locations[index].flag}'),
                    ),
                  ),
                ),
              );
            }
        ),
      );
    }
    else {
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
}
