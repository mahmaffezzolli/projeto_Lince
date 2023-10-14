import 'package:flutter/material.dart';
import 'package:projeto_final/view/login_page.dart';

const Color fundo = Color.fromRGBO(70, 130, 169, 1);

class Start extends StatelessWidget {
  const Start({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    });

    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: fundo,
      ),
      home: Center(
        child: Scaffold(
          appBar: null,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/car.png',
                  height: 200,
                  width: 200,
                ),
                const Text(
                  'VisionCar',
                  style: TextStyle(
                    fontFamily: 'Font',
                    fontSize: 44,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
