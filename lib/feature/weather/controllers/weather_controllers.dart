import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:weather_app/feature/weather/data/models/weather_model.dart';
import 'package:weather_app/feature/weather/data/weather_api_service/weather_api_service.dart';

class WeatherController extends GetxController {

  final WeatherService _weatherService = WeatherService();


  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxString searchCity = ''.obs;
  Rx<WeatherModel?> weatherData = Rx<WeatherModel?>(null);

  @override
  void onInit() {
    super.onInit();
    fetchWeatherByCurrentLocation(); // App open hote hi location weather fetch
  }

  // Current Location Weather
  Future<void> fetchWeatherByCurrentLocation() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      // Permission check
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          errorMessage.value = 'Location permission denied!';
          return;
        }
      }

      // Location lo
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // Weather fetch karo
      WeatherModel? data = await _weatherService.getWeatherByLocation(
        position.latitude,
        position.longitude,
      );

      if (data != null) {
        weatherData.value = data;
      } else {
        errorMessage.value = 'Weather fetch nahi hua!';
      }

    } catch (e) {
      errorMessage.value = 'Error: $e';
    } finally {
      isLoading.value = false;
    }
  }

  // City Search Weather
  Future<void> fetchWeatherByCity(String city) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      WeatherModel? data = await _weatherService.getWeatherByCity(city);

      if (data != null) {
        weatherData.value = data;
      } else {
        errorMessage.value = 'City not found — check them!';
      }

    } catch (e) {
      errorMessage.value = 'Error: $e';
    } finally {
      isLoading.value = false;
    }
  }

  /// Temperature format helper
  String formatTemp(double temp) => "${temp.toStringAsFixed(1)}°C";
}