import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Weather with ChangeNotifier {
  final String key = '90148420274ab156a4b372cb991d351f&units=metric';
  final String url = 'https://api.openweathermap.org/data/2.5/weather';

  Map<String, dynamic> _weatherInfo;

  bool _loading = false;

  bool get loading => _loading;
  Map<String, dynamic> get weatherInfo => _weatherInfo;

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<bool> getWeather(String cityName) async {
    setLoading(true);
    http.Response response = await http.get('$url?q=$cityName&appid=$key');
    setLoading(false);

    if (response.statusCode == 200) {
      _weatherInfo = json.decode(response.body);
      notifyListeners();
      return true;
    } else {
      print('Fail to get weather');
      return false;
    }
  }
}