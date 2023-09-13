import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../repositories/vehicle_repositorie.dart';

class PricePurchaseDateScreen extends StatelessWidget {
  const PricePurchaseDateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vehicleProvider = Provider.of<VehicleProvider>(context);

    return Scaffold(
      appBar: null,
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
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
                      onChanged: (value) {
                        vehicleProvider
                            .setPrice(double.parse(value).toString());
                      },
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      decoration: const InputDecoration(
                        labelText: 'Price Paid by the Store',
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Add a date picker widget here for selecting the purchase date
                    TextFormField(
                      onChanged: (value) {
                        // You can handle the purchase date here
                      },
                      decoration: const InputDecoration(
                        labelText: 'Purchase Date',
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        // You can save the vehicle data here
                        vehicleProvider.reset();
                        Navigator.popUntil(
                          context,
                          ModalRoute.withName("/model_brand"),
                        );
                      },
                      child: const Text('Finish'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
