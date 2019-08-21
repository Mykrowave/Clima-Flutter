import 'dart:convert';

import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey = '0a237d26a43c49bd30a71bffc33a0f0d';
  final String apiDomain = 'https://api.openweathermap.org';

  Future<dynamic> getCurrentWeatherData(
      double longitude, double lattitude) async {
    String url =
        '$apiDomain/data/2.5/weather?lat=$lattitude&lon=$longitude&APPID=$apiKey&units=metric';
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);
      return decodedData;
    } else {
      return null;
    }
  }

  Future<dynamic> getCurrentWeatherDataByCity(String cityName) async {
    String url =
        '$apiDomain/data/2.5/weather?q=$cityName&APPID=$apiKey&units=metric';
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);
      return decodedData;
    } else {
      return null;
    }
  }
}
