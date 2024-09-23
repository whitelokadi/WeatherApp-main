import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/homescreen.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 16, 125, 215),
                  Color.fromARGB(255, 34, 227, 211),
                  Colors.lightBlueAccent
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: double.infinity,
                  child: Lottie.asset('assets/images/animation.json'),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: double.infinity,
                  child: Container(
                    padding: EdgeInsets.all(
                        MediaQuery.of(context).size.width * 0.05),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: const [
                        BoxShadow(color: Colors.black38, blurRadius: 20)
                      ],
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Check real-time',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 37,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            'Weather!',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 37,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          const Text(
                              'A weather app offers current and future weather forecasts to help users plan their day effectively.'),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.07,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Homescreen(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                              ),
                              child: const Text(
                                'Get Started',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
