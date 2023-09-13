import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../repositories/vehicle_repositorie.dart';

class ManufacturePlateScreen extends StatelessWidget {
  const ManufacturePlateScreen({Key? key}) : super(key: key);

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
                        value: 0.4,
                        backgroundColor: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      onChanged: (value) {
                        vehicleProvider.setManufactureYear(value);
                      },
                      decoration: const InputDecoration(
                        labelText: 'Manufacture Year',
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      onChanged: (value) {
                        vehicleProvider.setPlate(value);
                      },
                      decoration: const InputDecoration(
                        labelText: 'Vehicle Plate',
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/vehicle_year_photo');
                      },
                      child: const Text('Next'),
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
