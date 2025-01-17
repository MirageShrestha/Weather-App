import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:weather_app/additional_info_item.dart';
import 'package:weather_app/hourly_forecast_item.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/secrets.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {

  @override
  void initState(){
    super.initState();
    getCurrentWeather();
  }
  Future getCurrentWeather() async {
    String cityName ='Kathmandu';
    final res = await http.get(
      Uri.parse(
        'https://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=$openWeaterAPIKey'
      ),
    );
    print(res.body);
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Weather App', 
          style: TextStyle(
          fontWeight: FontWeight.w500,
        ),
        ),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){}, 
          icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //main card
            SizedBox(
              width: double.infinity,
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 3, sigmaY: 3),
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text('300°K', 
                          style: TextStyle(
                           fontSize: 32,
                           fontWeight: FontWeight.bold,
                          ),
                          ),
                          Icon(
                            Icons.cloud,
                            size: 64,
                          ),
                          Text('Rain',
                          style: TextStyle(
                            fontSize: 30,
                          ),
                          ),
                      ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height:10),
            const Text('Weather Forecast',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            ),
            const SizedBox(height: 10),
            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  HourlyForecastItem(
                    time: '00:00',
                    temperature: '301.22',
                    icon: Icons.cloud ,
                  ),
                  HourlyForecastItem(
                    time: '03:00',
                    temperature: '300.52',
                    icon: Icons.sunny ,
                  ),
                  HourlyForecastItem(
                    time: '06:00',
                    temperature: '301.22',
                    icon: Icons.cloud ,
                  ),
                  HourlyForecastItem(
                    time: '09:00',
                    temperature: '302.22',
                    icon: Icons.sunny ,
                  ),
                  HourlyForecastItem(
                    time: '12:00',
                    temperature: '301.22',
                    icon: Icons.sunny,
                  ),
                ],
              ),
            ),
            //weather forecast cards
            const SizedBox(height: 10),
            //additional information
            const Text('Additional Information',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            ),
            const SizedBox(height: 10),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
              AdditionalInfoItem(
                icon: Icons.water_drop,
                label: 'Humidity',
                value: '91',
              ),
              AdditionalInfoItem(
                icon: Icons.air,
                label: 'Wind Speer',
                value: '7.7',
              ),
              AdditionalInfoItem(
                icon: Icons.beach_access,
                label: 'Pressure',
                value: '1008',
              ),
            ],),

            
          ],
        ),
      ),
    );
  }
}

