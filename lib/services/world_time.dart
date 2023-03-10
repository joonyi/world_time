import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String? location;
  late String time;
  String? flag;
  String? url;
  late bool isDaytime;

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async {

    try {
      Response response = await get(Uri.parse('https://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);
      // print(data);

      String datetime = data['datetime'];
      // print(datetime);
      String utc_offset = data['utc_offset'].substring(1,3);
      // print(utc_offset);

      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(utc_offset)));

      isDaytime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);

    } catch(e) {
      print('caught error: $e');
      time = 'could not get time data';
    }
  }
}