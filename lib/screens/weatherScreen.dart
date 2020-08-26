import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:loginstudy/provider/weather.dart';
import 'package:loginstudy/shared/constants.dart';


//void main() => runApp(MyApp());

class WeatherScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Provider Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
//        primarySwatch: Colors.deepOrange,
//        accentColor: Colors.brown,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Weather>.value(value: Weather()),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text('Urban Weather Information'),
        ),
        body: Stack(
          children: <Widget>[
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,

                  /* import 해주어야 오류 발생하지 않음*/
                  colors: [
                    login_Gradient1,
                    login_Gradient2,
                    login_Gradient3,
                    login_Gradient4,
                  ],
                  stops: [0.1, 0.4, 0.7, 0.9],
                ),
              ),
            ),
            Column(
//              crossAxisAlignment: CrossAxisAlignment.start,
//              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 50.0,),
                ),
                Text(
                  'How\'s the Weather today?',
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10.0,),
                Text(
                  'Please enter the name of the city in the search box below.',
                  style: TextStyle(
                    color: Colors.white54,
                  ),
                ),
                SizedBox(height: 10.0,),
                MyWeather(),
              ],
            ),


//            MyCounter(),
//            MyButtons(),
//            Divider(color: Colors.grey),
          ],
        ),
      ),
    );
  }
}



class MyWeather extends StatefulWidget {
  @override
  _MyWeatherState createState() => _MyWeatherState();
}

class _MyWeatherState extends State<MyWeather> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _locationController = TextEditingController();
  bool _autovalidate = false;

  @override
  void dispose(){
    _locationController.dispose();
    super.dispose();
  }

  _submit(Weather weather) {
    final form = _formKey.currentState;

    if (form.validate()) {
      final cityName = _locationController.text;
      print(cityName);
      weather.getWeather(cityName);
    } else {
      _autovalidate = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    var weather = Provider.of<Weather>(context);

    //날씨
    var mainWeatherDesc = weather.weatherInfo == null
        ? ''
        : weather.weatherInfo['weather'][0]['main'];
    //온도
    var celsiusTemp = weather.weatherInfo == null ? '' : weather.weatherInfo['main']['temp'];

    //최대온도
    var maxTemp = weather.weatherInfo == null ? '' : weather.weatherInfo['main']['temp_max'].toString();
    //최소온도
    var minTemp = weather.weatherInfo == null ? '' : weather.weatherInfo['main']['temp_min'].toString();
    //습도
    var humidity = weather.weatherInfo == null ? '' : weather.weatherInfo['main']['humidity'].toString();
    //풍속
    var windSpeed = weather.weatherInfo == null ? '' : weather.weatherInfo['wind']['speed'].toString();
    //도시이름
    var cityName = weather.weatherInfo == null ? '' : weather.weatherInfo['name'];


    return Form(
      key: _formKey,
      autovalidate: _autovalidate,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 36.0,
          horizontal: 16.0,
        ),
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: _locationController,
              decoration: InputDecoration(
                filled: true, /*텍스트 필드 배경 색 채우기 여부*/
                prefixIcon: Icon(Icons.search, color: Colors.white,),
                labelText: 'City of Countries',
                labelStyle: TextStyle(color: Colors.white54,),
                hintText: 'Enter Location to watch for',
              ),
              validator: (value) {
                return value.length <= 1 ? 'Loaction too short' : null;
              },
            ),
            mainWeatherDesc.length > 0
                ? Padding( // 조건 ? 조건이 맞으면 실행 : 조건이 틀리면 실행
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Column(
                children: <Widget>[
                  Text(
                    cityName + '\'s weather Info',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white70,
                    ),
                  ),
                  SizedBox(height: 20.0,),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.cloud, color: Colors.white,),
                        Padding(padding: EdgeInsets.only(right: 10.0, bottom: 50.0,),),
                        Text(
                          'Weather : ' + mainWeatherDesc,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.wb_sunny, color: Colors.white,),
                        Padding(
                          padding: EdgeInsets.only(right: 10.0,bottom: 50.0,),
                        ),
                        Text(
                          'Current Temperature : '+celsiusTemp.toString()+'℃',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.wb_sunny, color: Colors.white,),
                        Padding(
                          padding: EdgeInsets.only(right: 10.0,bottom: 50.0,),
                        ),
                        Text(
                          'Minimum Temperature : '+minTemp+'℃',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.wb_sunny, color: Colors.white,),
                        Padding(
                          padding: EdgeInsets.only(right: 10.0,bottom: 50.0,),
                        ),
                        Text(
                          'Maximum Temperature : '+maxTemp+'℃',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.opacity, color: Colors.white,),
                        Padding(padding: EdgeInsets.only(right: 10.0,bottom: 50.0,),),
                        Text(
                          'Humidity : '+humidity+'%',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.toys, color: Colors.white,),
                        Padding(padding: EdgeInsets.only(right: 10.0,bottom: 50.0,),),
                        Text(
                          'Wind Speed : '+windSpeed+'m/s',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            )
                : Container(),
            Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: RaisedButton(
                onPressed: () {
                  _submit(weather);
                },
                child: weather.loading
                    ? SizedBox(
                  width: 25,
                  height: 25,
                  child: CircularProgressIndicator(),
                )
                    : Text('Get Weather'),
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}