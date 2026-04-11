import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/feature/weather/data/models/weather_model.dart';


class WeatherService {

  static const String _apiKey = "6478862bf69bbf6041d2bab6d27f7102";
  static const String _baseUrl = "https://api.openweathermap.org/data/2.5/weather";

  // City se weather fetch karo
  Future<WeatherModel?> getWeatherByCity(String city) async {
    try {
      final response = await http.get(
        Uri.parse("$_baseUrl?q=$city&appid=$_apiKey"),
      );

      if (response.statusCode == 200) {
        return WeatherModel.fromJson(jsonDecode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  // Lat/Long se weather fetching function
  Future<WeatherModel?> getWeatherByLocation(double lat, double lon) async {
    try {
      final response = await http.get(
        Uri.parse("$_baseUrl?lat=$lat&lon=$lon&appid=$_apiKey"),
      );

      if (response.statusCode == 200) {
        return WeatherModel.fromJson(jsonDecode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}