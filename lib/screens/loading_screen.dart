import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const String apiKey = '0a237d26a43c49bd30a71bffc33a0f0d';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  LocationService _locationService = new LocationService();
  WeatherService _weatherService = new WeatherService();

  Position _currentPosition;

  @override
  void initState() {
    super.initState();
    getLocationAndWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SpinKitChasingDots(
          color: Colors.white,
        ),
        );
  }

  Future<void> getLocationAndWeather() async {
    _currentPosition = await _locationService.getCurrentLocation();
    var weatherData = await _weatherService.getCurrentWeatherData(
        _currentPosition.longitude, _currentPosition.latitude);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LocationScreen(weatherData: weatherData)));
  }

  
}
