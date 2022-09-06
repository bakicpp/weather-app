import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hava_durumu/utils/weather.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key, required this.weatherData}) : super(key: key);

  final WeatherData weatherData;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int temperature;
  late Icon weatherDisplayIcon;
  late AssetImage backgroundImage;
  late String? city;
  late String? country;

  void updateDisplayInfo(WeatherData weatherData) {
    setState(() {
      temperature = weatherData.currentTemperature!.round();
      city = weatherData.city;
      country = weatherData.country;
      WeatherDisplayData? weatherDisplayData =
          weatherData.getWeatherDisplayData();

      backgroundImage = weatherDisplayData!.weatherImage;
      weatherDisplayIcon = weatherDisplayData.weatherIcon;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateDisplayInfo(widget.weatherData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
            image: DecorationImage(image: backgroundImage, fit: BoxFit.cover)),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.4,
          height: MediaQuery.of(context).size.height * 0.4,
          color: Colors.black45,
          child: Column(
            children: [
              SizedBox(
                height: 100,
              ),
              Container(
                child: weatherDisplayIcon,
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                child: Text(
                  '$temperature°',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 100,
                    color: Colors.white,
                    letterSpacing: -5,
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Center(
                child: Text(
                  city.toString(),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Center(
                child: Text(
                  country.toString(),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 38,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
