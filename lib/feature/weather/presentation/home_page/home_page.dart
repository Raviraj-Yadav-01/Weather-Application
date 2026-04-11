import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/feature/weather/controllers/weather_controllers.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final WeatherController controller = Get.find<WeatherController>();
    var searchController = TextEditingController();

    return Scaffold(
      //backgroundColor: Colors.blue.shade900,
      backgroundColor: Color(0xFFEDE7F6),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1565C0),
              //Dark Blue from upper side
              Color(0xFF42A5F5),
              //Medium Blue from lower side
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                /// Search field  ///
                TextField(
                  controller: searchController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Search your favourite city...",
                    hintStyle: TextStyle(color: Colors.white60),
                    prefixIcon: Icon(Icons.search, color: Colors.white),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.send, color: Colors.white),
                      onPressed: () {
                        if (searchController.text.isNotEmpty) {
                          controller.fetchWeatherByCity(
                            searchController.text.trim(),
                          );
                        }
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: Colors.white54),
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // Weather
                Expanded(
                  child: Obx(() {
                    // Loading
                    if (controller.isLoading.value) {
                      return Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      );
                    }

                    //  if Error
                    if (controller.errorMessage.value.isNotEmpty) {
                      return Center(
                        child: Text(
                          controller.errorMessage.value,
                          style: TextStyle(color: Colors.red, fontSize: 16),
                        ),
                      );
                    }

                    //No Data
                    if (controller.weatherData.value == null) {
                      return Center(
                        child: Text(
                          "Weather is loading...",
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }

                    final weather = controller.weatherData.value!;

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // City Name
                        Text(
                          weather.cityName,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),

                        // Condition
                        Text(
                          weather.description.toUpperCase(),
                          style: TextStyle(color: Colors.white70, fontSize: 16),
                        ),
                        SizedBox(height: 20),

                        //Weather Icon
                        Image.network(
                          "https://openweathermap.org/img/wn/${weather.icon}@2x.png",
                          width: 100,
                          height: 100,
                        ),
                        SizedBox(height: 10),

                        //Temperature
                        Text(
                          controller.formatTemp(weather.temperature),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 72,
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                        SizedBox(height: 30),

                        //Details Card
                        Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _weatherDetail(
                                Icons.water_drop,
                                "${weather.humidity}%",
                                "Humidity",
                              ),
                              _weatherDetail(
                                Icons.air,
                                "${weather.windSpeed} m/s",
                                "Wind",
                              ),
                              _weatherDetail(
                                Icons.thermostat,
                                controller.formatTemp(weather.feelsLike),
                                "Feels Like",
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),

                        //Refresh Button on every searching
                        ElevatedButton.icon(
                          onPressed: () =>
                              controller.fetchWeatherByCurrentLocation(),
                          icon: Icon(Icons.my_location),
                          label: Text("Current Location"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.blue.shade900,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _weatherDetail(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 28),
        SizedBox(height: 6),
        Text(value, style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
        Text(label, style: TextStyle(color: Colors.white70, fontSize: 12)),
      ],
    );
  }
}
