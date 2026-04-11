class WeatherModel {

   String cityName;
   double temperature;
   double feelsLike;
   double tempMin;
   double tempMax;
   int humidity;
   String condition;
   String description;
   String icon;
   double windSpeed;

  WeatherModel({
    required this.cityName,
    required this.temperature,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.humidity,
    required this.condition,
    required this.description,
    required this.icon,
    required this.windSpeed,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json['name'],
      temperature: (json['main']['temp'] - 273.15), // Kelvin to Celsius
      feelsLike: (json['main']['feels_like'] - 273.15),
      tempMin: (json['main']['temp_min'] - 273.15),
      tempMax: (json['main']['temp_max'] - 273.15),
      humidity: json['main']['humidity'],
      condition: json['weather'][0]['main'],
      description: json['weather'][0]['description'],
      icon: json['weather'][0]['icon'],
      windSpeed: json['wind']['speed'].toDouble(),
    );
  }
}
