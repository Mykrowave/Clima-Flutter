import 'package:clima/screens/city_screen.dart';
import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'package:geolocator/geolocator.dart';

class LocationScreen extends StatefulWidget {
  final dynamic weatherData;
  LocationScreen({this.weatherData});

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  LocationService locationService = new LocationService();
  WeatherService weatherService = new WeatherService();
  WeatherModel weatherModel = WeatherModel();

  int _temperature;
  String _weatherIcon;
  String _weatherMessage;
  String _cityName;

  @override
  void initState() {
    super.initState();
    updateLocationAndWeatherVariables(widget.weatherData);
  }

  void updateLocationAndWeatherVariables(dynamic weatherData) {
    setState(() {
      double temp = weatherData['main']['temp'];
      _temperature = temp.toInt();
      int conditionId = weatherData['weather'][0]['id'];
      _weatherIcon = weatherModel.getWeatherIcon(conditionId);
      _weatherMessage = weatherModel.getMessage(_temperature);
      _cityName = weatherData['name'];
    });
  }

  Future<dynamic> getLocationAndWeather() async {
    Position position = await locationService.getCurrentLocation();
    dynamic weatherData = await weatherService.getCurrentWeatherData(
        position.longitude, position.latitude);
    return weatherData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      dynamic weatherData = await getLocationAndWeather();
                      updateLocationAndWeatherVariables(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      dynamic weatherData = await Navigator.push(context, MaterialPageRoute(builder: (context) => CityScreen()));
                      updateLocationAndWeatherVariables(weatherData);
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$_temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      _weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  '$_weatherMessage in $_cityName',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
