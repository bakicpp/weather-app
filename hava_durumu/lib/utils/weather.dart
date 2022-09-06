import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';

import 'location.dart';

const apiKey = "8609e85b9da6bb05d023144c6f9ed975";

class WeatherDisplayData {
  Icon weatherIcon;
  AssetImage weatherImage;

  WeatherDisplayData({required this.weatherIcon, required this.weatherImage});
}

class WeatherData {
  WeatherData({required this.locationData});

  LocationHelper locationData;
  double? currentTemperature;
  int? currentCondition;
  String? city;
  String? country;

  Future<void> getCurrentTemperature() async {
    final Uri url = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?lat=${locationData.latitude}&lon=${locationData.longitude}&appid=${apiKey}&units=metric");

    Response response = await get(url);

    if (response.statusCode == 200) {
      String data = response.body;

      var currentWeather = jsonDecode(data);

      try {
        currentTemperature = currentWeather['main']['temp'];
        currentCondition = currentWeather['weather'][0]['id'];
        city = currentWeather['name'];
        country = currentWeather['sys']['country'];
      } catch (e) {
        print(e);
      }
    } else {
      print("API'den deger gelmiyor");
    }
  }

  WeatherDisplayData? getWeatherDisplayData() {
    if (currentCondition! < 600) {
      return WeatherDisplayData(
          weatherIcon: Icon(
            FontAwesomeIcons.cloud,
          ),
          weatherImage: AssetImage('images/bulutlu.jpg'));
    } else {
      //hava iyi
      //gece gündüz kontrolü

      var now = new DateTime.now();
      if (now.hour >= 19) {
        return WeatherDisplayData(
            weatherIcon: Icon(FontAwesomeIcons.moon),
            weatherImage: AssetImage('images/gece.jpg'));
      } else {
        return WeatherDisplayData(
            weatherIcon: Icon(
              FontAwesomeIcons.sun,
              size: 100,
              color: Colors.white,
            ),
            weatherImage: AssetImage('images/gunesli.jpg'));
      }
    }
  }
}
