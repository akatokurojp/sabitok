import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:lottie/lottie.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:sabitok/widgets/custom_button.dart';

class WeatherApp extends StatefulWidget {
  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  String city = 'Jakarta';
  String temperature = '0';
  String apiKey = 'd9fcf64561c1d2f9fdc8e3654a4cac95';
  late String _newCity;
  String _weatherURL =
      'https://assets3.lottiefiles.com/packages/lf20_fi2zcy9b.json';

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  void fetchWeather() async {
    // _weatherURL = 'https://assets3.lottiefiles.com/packages/lf20_fi2zcy9b.json';
    var response = await http.get(Uri.parse(
        'http://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey'));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      setState(() {
        double tempKelvin = data['main']['temp'];
        double tempCelsius = tempKelvin - 273.15;
        temperature = tempCelsius.toStringAsFixed(2) + '°C';
        city = data['name'];
        // check weather condition to show the appropriate image
        int condition = data['weather'][0]['id'];
        if (condition < 300) {
          _weatherURL =
              'https://assets6.lottiefiles.com/packages/lf20_57ui5yd5.json'; //thunderstorm
        } else if (condition < 400) {
          _weatherURL =
              'https://assets2.lottiefiles.com/packages/lf20_jmBauI.json'; //drizzle
        } else if (condition < 600) {
          _weatherURL =
              'https://assets2.lottiefiles.com/packages/lf20_oAByvh2C1K.json'; //rain
        } else if (condition < 700) {
          _weatherURL =
              'https://assets10.lottiefiles.com/temp/lf20_WtPCZs.json'; //snow
        } else if (condition < 800) {
          _weatherURL =
              'https://assets3.lottiefiles.com/packages/lf20_fyCT0F.json'; //fog
        } else if (condition == 800) {
          _weatherURL =
              'https://assets6.lottiefiles.com/temp/lf20_Stdaec.json'; //clear
        } else if (condition <= 804) {
          _weatherURL =
              'https://assets3.lottiefiles.com/packages/lf20_uuzf4huo.json'; //cloud
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 200,
              height: 200,
            ),
            CachedNetworkImage(
              imageUrl: _weatherURL,
              placeholder: (context, url) => Lottie.network(url),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            Text('Temperature in $city: $temperature'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  _newCity = value;
                },
                decoration: InputDecoration(
                    labelText: 'City',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: CustomButton(
                text: ('Confirm'),
                onTap: () {
                  setState(() {
                    city = _newCity;
                    fetchWeather();
                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
