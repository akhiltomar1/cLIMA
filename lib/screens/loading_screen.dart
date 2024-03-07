import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const apikey = '362971d0c7731889aa2c57be3f7ebf72';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  late double latitude;
  late double longitude;


  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {

    Location location = new Location();
    await location.getcurrentlocation();
    latitude = location.lat;
    longitude = location.long;

    getData();
  }
  
  Future <void> getData() async {
    http.Response response = await http.get('https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apikey' as Uri);

    if(response.statusCode == 200){
      String data = response.body;

      var decodeData = jsonDecode(data);

      var temp = decodeData['main']['temp'];
      var condition = decodeData['weather'][0]['id'];
      var cityname = decodeData['name'];
      
      print(temp);
      print(condition);
      print(cityname);

    } else{
      print(response.statusCode);
    }
  }


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            //Get the current location
            getLocation();
          },
          child: Text('Get Location'),
        ),
      ),
    );
  }
}
