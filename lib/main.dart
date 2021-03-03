import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() => runApp(MaterialApp(

      title: "Wealther APP",
      home: Home(),
    ));

class Home extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  var temp;
  var description;
  var currently;
  var windspeed;
  var humidity;
  var name;

  Future getWeather() async {
    http.Response response = await http.get(
        "http://api.openweathermap.org/data/2.5/weather?q=Lagos&appid=804e9054180d8cb4bb2013bbf9484398");
    var result = jsonDecode(response.body);

    setState(() {
      this.temp = result['main']['temp'];
      this.description = result['weather'][0]['description'];
      this.currently = result['main']['humidity'];
      this.windspeed = result['wind']['speed'];
      this.name = result['name'];
    });
  }

  @override
  void initState() {
    super.initState();
    this.getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Center(
              child: Stack(
                children: <Widget>[
                  Container(
                    //color: Colors.deepPurpleAccent,
                    height: 300,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage('assets/image.jpg'),
                      fit: BoxFit.cover,
                    )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: Center(
                      child: Container(
                        margin: EdgeInsets.only(top: 80, left: 10),
                        height: 120,
                        width: 120,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Text(
                                      name != null
                                          ? name.toString()
                                          : "Loading",
                                      style: TextStyle(
                                          fontSize: 25, color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    temp != null
                                        ? (temp / 10).round().toString() +
                                            "\u00B0"
                                        : "Loading",
                                    style: TextStyle(
                                        fontSize: 30, color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: ListView(
                  children: <Widget>[
                    ListTile(
                      leading: FaIcon(FontAwesomeIcons.thermometerHalf),
                      title: Text("Temprature"),
                      trailing: Text(temp != null
                          ? (temp / 10).round().toString() + "\u00B0"
                          : "Loading"),
                    ),
                    ListTile(
                      leading: FaIcon(FontAwesomeIcons.cloud),
                      title: Text("Weather"),
                      trailing: Text(description != null
                          ? description.toString()
                          : "loading"),
                    ),
                    ListTile(
                      leading: FaIcon(FontAwesomeIcons.sun),
                      title: Text("Humidity"),
                      trailing: Text(
                          currently != null ? currently.toString() : 'Loading'),
                    ),
                    ListTile(
                      leading: FaIcon(FontAwesomeIcons.wind),
                      title: Text("Wind Speed"),
                      trailing: Text(
                          windspeed != null ? windspeed.toString() : "loading"),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
