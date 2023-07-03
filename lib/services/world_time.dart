import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location = "";
  String time = "";
  String flag = "";
  String url = "";
  bool isDayTime = false;

  WorldTime({required this.location,required this.flag,required this.url});

  Future<void> getTime() async {
    // make the re quest
    try {
      final response = await http.get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);

      // Extract hours and minutes from the offset string
      int offsetHours = int.parse(data['utc_offset'].substring(1, 3));
      int offsetMinutes = int.parse(data['utc_offset'].substring(4, 6));

      // Create DateTime object and add the offset
      DateTime now = DateTime.parse(data['datetime']);
      now = now.add(Duration(hours: offsetHours, minutes: offsetMinutes));

      // set time property
      isDayTime = now.hour > 6 && now.hour < 20 ? true:false;
      time = DateFormat.jm().format(now);
    }
    catch(e) {
      time = 'could not get the time';
    }
  }
}
