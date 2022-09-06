import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hava_durumu/utils/location.dart';
import 'package:hava_durumu/utils/weather.dart';

import '../constants.dart';
import 'main_screen.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late LocationHelper locationData;

  Future<void> getLocationData() async {
    locationData = LocationHelper();
    await locationData?.getCurrentLocation();

    if (locationData?.latitude == null || locationData?.longitude == null) {
      print("konum bilgisi alınamadı");
    } else {
      print("latitude: " + locationData!.latitude.toString());
      print("longitude: " + locationData!.longitude.toString());
    }
  }

  void getWeatherData() async {
    await getLocationData();

    WeatherData weatherData = WeatherData(locationData: locationData);
    await weatherData.getCurrentTemperature();

    if (weatherData.currentTemperature == null ||
        weatherData.currentCondition == null) {
      print("API'den sıcaklık veya durum bilgisi boş dönüyor");
    }

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return MainScreen(
        weatherData: weatherData,
      );
    }));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [blu1, blu2])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 200),
              child: SpinKitChasingDots(
                color: Colors.white,
                size: 50,
                duration: Duration(milliseconds: 2400),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 200),
              child: Text(
                "weather.",
                style: GoogleFonts.poppins(
                  fontSize: 21,
                  color: Colors.white70,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
