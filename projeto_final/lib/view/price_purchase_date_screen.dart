import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../vehicle_list_provider.dart';
import 'home_screen.dart';

const Color fundo = Color.fromRGBO(70, 130, 169, 1);

class PricePurchaseDateScreen extends StatelessWidget {
  PricePurchaseDateScreen({Key? key}) : super(key: key);

  final TextEditingController priceController = TextEditingController();
  final TextEditingController purchaseDateController = TextEditingController();
  final TextEditingController modelController = TextEditingController();
  final TextEditingController brandController = TextEditingController();
  final TextEditingController manufactureYearController =
      TextEditingController();
  final TextEditingController plateController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  void _selectDate(
      BuildContext context, ValueSetter<String> onDateSelected) async {
    final DateTime picked = (await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        )) ??
        DateTime.now();

    onDateSelected(DateFormat('yyyy-MM-dd').format(picked));
  }

  void _registerVehicle(BuildContext context) {
    try {
      final vehicleListProvider =
          Provider.of<VehicleListProvider>(context, listen: false);

      final success = vehicleListProvider.insertVehicle(
        priceController.text,
        purchaseDateController.text,
        modelController.text,
        brandController.text,
        manufactureYearController.text,
        plateController.text,
        dateController.text,
      );

      if (success == true) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Veículo registrado com sucesso!'),
          duration: Duration(seconds: 2),
        ));
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Falha ao registrar o veículo. Verifique os campos obrigatórios.'),
          duration: Duration(seconds: 2),
        ));
      }
    } catch (e) {
      // Lida com exceções aqui
      print('Erro ao registrar o veículo: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Erro ao registrar o veículo: $e'),
        duration: const Duration(seconds: 2),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<VehicleListProvider>(
      builder: (context, vehicleListProvider, child) {
        return MaterialApp(
          theme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: fundo,
          ),
          home: Scaffold(
            appBar: null,
            body: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: [
                    Positioned.fill(
                      bottom: 90,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(246, 244, 235, 1),
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(50),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                'Vehicle Registration',
                                style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.blue,
                                ),
                              ),
                              const SizedBox(height: 20),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: const LinearProgressIndicator(
                                  value: 0.8,
                                  backgroundColor: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 20),
                              TextFormField(
                                style: const TextStyle(color: Colors.black),
                                controller: priceController,
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                  decimal: true,
                                ),
                                decoration: const InputDecoration(
                                  labelText: 'Price Paid by the Store',
                                  labelStyle: TextStyle(color: Colors.black),
                                  suffixIcon: Icon(
                                    Icons.monetization_on,
                                    color: Colors.black,
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue, width: 2.0),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 1.0),
                                  ),
                                  hintStyle: TextStyle(color: Colors.black),
                                ),
                              ),
                              const SizedBox(height: 20),
                              TextFormField(
                                style: const TextStyle(color: Colors.black),
                                controller: purchaseDateController,
                                readOnly: true,
                                onTap: () {
                                  _selectDate(context, (date) {
                                    purchaseDateController.text = date;
                                  });
                                },
                                decoration: const InputDecoration(
                                  labelText: 'Purchase Date',
                                  suffixIcon: Icon(
                                    Icons.calendar_today,
                                    color: Colors.black,
                                  ),
                                  labelStyle: TextStyle(color: Colors.black),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue, width: 2.0),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 1.0),
                                  ),
                                  hintStyle: TextStyle(color: Colors.black),
                                ),
                              ),
                              const SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: () {
                                  _registerVehicle(context);
                                },
                                child: const Text("Cadastrar"),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
