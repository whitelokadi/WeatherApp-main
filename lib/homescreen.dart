import 'package:flutter/material.dart';
import 'package:weather/weather.dart';
import 'package:intl/intl.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final WeatherFactory _wf = WeatherFactory('1953b515f04d1c8c8f8754895975dddf');
  Weather? _weather;
  TextEditingController cont = TextEditingController();
  Future<void> _fetchweather(String cityname) async {
    try {
      Weather weather = await _wf.currentWeatherByCityName(cityname);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Not found')));
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchweather('Bahawalpur');
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            height: 150,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.deepPurple[400],
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              boxShadow: const [BoxShadow(blurRadius: 20, color: Colors.black)],
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    'Weather App',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    height: 50,
                    child: TextField(
                      controller: cont,
                      decoration: InputDecoration(
                        hintText: 'Search the city here',
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        filled: true,
                        prefixIcon: const Icon(Icons.search, size: 30),
                        suffixIcon: IconButton(
                          icon: const Icon(
                            Icons.arrow_forward,
                            size: 30,
                            color: Colors.blue,
                          ),
                          onPressed: () {
                            _fetchweather(cont.text);
                          },
                        ),
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_weather != null) ...[
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          size: 40,
                        ),
                        Text(
                          _weather!.areaName!,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${_weather!.temperature!.celsius!.toStringAsFixed(0)} °C',
                            style: TextStyle(
                              fontSize: width * 0.22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            _weather!.weatherDescription!,
                            style: TextStyle(
                                fontSize: width * 0.05,
                                overflow: TextOverflow.fade),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: width * 0.35,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            'http://openweathermap.org/img/wn/${_weather!.weatherIcon}@4x.png',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 0),
                    Card(
                      shadowColor: Colors.black,
                      color: const Color.fromARGB(255, 33, 240, 243),
                      child: SizedBox(
                        height: 200,
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  DateFormat('h:mm a').format(_weather!.date!),
                                  style: const TextStyle(
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  DateFormat('M.d.y').format(_weather!.date!),
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Max: ${_weather!.tempMax!.celsius!.toStringAsFixed(0)} °C',
                                  style: const TextStyle(fontSize: 20),
                                ),
                                Text(
                                  'Min: ${_weather!.tempMin!.celsius!.toStringAsFixed(0)} °C',
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Wind: ${_weather!.windSpeed!.toStringAsFixed(0)} m/s',
                                  style: const TextStyle(fontSize: 20),
                                ),
                                Text(
                                  'Humidity: ${_weather!.humidity!.toStringAsFixed(0)} %',
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ] else ...[
            const Center(
              child: CircularProgressIndicator(),
            )
          ]
        ]),
      ),
    );
  }
}
