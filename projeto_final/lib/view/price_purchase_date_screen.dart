import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../repositories/vehicle_repositorie.dart';

const Color fundo = Color.fromRGBO(70, 130, 169, 1);

class PricePurchaseDateScreen extends StatelessWidget {
  const PricePurchaseDateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController priceController = TextEditingController();
    final TextEditingController purchaseDateController =
        TextEditingController();
    DateTime? selectedDate;

    // ignore: no_leading_underscores_for_local_identifiers
    void _selectDate(BuildContext context) async {
      final DateTime picked = (await showDatePicker(
            context: context,
            initialDate: selectedDate ?? DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
          )) ??
          DateTime.now();

      if (picked != selectedDate) {
        selectedDate = picked;
        purchaseDateController.text = "${picked.toLocal()}".split(' ')[0];
      }
    }

    void _navigateToNextScreen(BuildContext context) {
      final vehicleProvider =
          Provider.of<VehicleProvider>(context, listen: false);
      final price = priceController.text;
      final purchaseDate = purchaseDateController.text;

      if (price.isNotEmpty && purchaseDate.isNotEmpty) {
        Navigator.pushNamed(context, '/next_screen');
        vehicleProvider.reset();
        Navigator.popUntil(
          context,
          ModalRoute.withName("/model_brand"),
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              actionsAlignment: MainAxisAlignment.center,
              title: const Text('Error', style: TextStyle(color: Colors.black)),
              backgroundColor: const Color.fromRGBO(255, 109, 96, 1),
              content: const Text(
                'Por favor, selecione os campos obrigatórios.',
                style: TextStyle(color: Colors.black),
              ),
              actions: <Widget>[
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(255, 234, 221, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'OK',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    }

    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: fundo,
      ),
      home: Scaffold(
        appBar: null,
        body: Stack(
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
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        decoration: const InputDecoration(
                          labelText: 'Price Paid by the Store',
                          labelStyle: TextStyle(color: Colors.black),
                          suffixIcon: Icon(
                            Icons.price_check,
                            color: Colors.black,
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2.0),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.0),
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
                          _selectDate(context);
                        },
                        decoration: const InputDecoration(
                          labelText: 'Purchase Date',
                          suffixIcon: Icon(
                            Icons.calendar_today,
                            color: Colors.black,
                          ),
                          labelStyle: TextStyle(color: Colors.black),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2.0),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.0),
                          ),
                          hintStyle: TextStyle(color: Colors.black),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.arrow_forward,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              _navigateToNextScreen(context);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
