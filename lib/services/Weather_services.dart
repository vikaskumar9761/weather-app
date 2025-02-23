import 'package:weather/models/weather_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class WeatherServices {
  final String apikey = 'Enter Your apiKey';

  //weather capture detail of function

Future<Weather> feachWeather(String cityName) async {
  final url= Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apikey'
  );

  final response= await http.get(url);

  if(response.statusCode==200){
    return Weather.fromJson(json.decode(response.body));
  }
  else{
    throw Exception("Failed to load weather data");

  }
}
}