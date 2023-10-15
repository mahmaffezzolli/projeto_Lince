// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:projeto_final/view/model_brand_screen.dart';
import 'package:projeto_final/view/register_screen.dart';
import 'package:projeto_final/view/settings_screen.dart';
import 'package:projeto_final/view/vehicle_list_screen.dart';
import 'package:provider/provider.dart';

import '../theme_provider.dart';
import 'document_name_screen.dart';
import 'plate_screen.dart';

const Color fundo = Color.fromRGBO(255, 255, 255, 1);

class Initial extends StatelessWidget {
  const Initial({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final ThemeData themeData =
        themeProvider.getTheme(scaffoldBackgroundColor: fundo);

    return MaterialApp(
      theme: themeData, // Set the theme here
      home: Scaffold(
        appBar: null,
        body: Column(
          children: [
            Container(
              height: 130,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(70, 130, 169, 1),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(50),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Title(
                        color: const Color.fromARGB(255, 44, 44, 44),
                        child: const Text(
                          "Olá, seja bem-vindo!",
                          style: TextStyle(
                            fontSize: 19,
                            color: Color.fromARGB(255, 27, 27, 27),
                          ),
                        ),
                      ),
                      const SizedBox(width: 90),
                      const Icon(
                        Icons.person,
                        color: Color.fromARGB(255, 44, 44, 44),
                        size: 30,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildButton(
                  icon: Icons.car_rental,
                  text: 'Cadastrar carro',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>  ModelBrandScreen(),
                      ),
                    );
                  },
                ),
                _buildButton(
                  icon: Icons.receipt_long,
                  text: 'Lista de carros',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const VehicleListScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildButton(
                  icon: Icons.add_shopping_cart,
                  text: 'Cadastrar venda',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const DocumentNameAndDatePriceScreen(),
                      ),
                    );
                  },
                ),
                _buildButton(
                  icon: Icons.app_registration,
                  text: 'Cadastrar usuário',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegisterScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(145, 200, 228, 1),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 50,
              color: Colors.white,
            ),
            const SizedBox(height: 10),
            Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
