import 'package:flutter/material.dart';
import 'package:projeto_final/entities/vehicle.dart';
import 'package:projeto_final/storages/vehicle_database.dart';

class VehicleListProvider with ChangeNotifier {
  List<Vehicle> vehicles = [];
  VehicleController vehicleDatabase;

  VehicleListProvider(this.vehicleDatabase) {
    loadVehicles();
  }

  Future<void> loadVehicles() async {
    try {
      List<Vehicle> loadedVehicles = await vehicleDatabase.getAllVehicles();
      vehicles = loadedVehicles;
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> deleteVehicle(Vehicle vehicle) async {
    final vehicleIndex = vehicles.indexWhere((v) => v.id == vehicle.id);

    if (vehicleIndex != -1) {
      await vehicleDatabase.deleteVehicle(vehicle.id!);
      vehicles.removeAt(vehicleIndex);
      notifyListeners();
    }
  }

  Future<void> updateVehicle(Vehicle vehicle) async {
    await vehicleDatabase.updateVehicle(vehicle);
    final vehicleIndex = vehicles.indexWhere((v) => v.id == vehicle.id);

    if (vehicleIndex != -1) {
      vehicles[vehicleIndex] = vehicle;
      notifyListeners();
    }
  }

  Future<void> insertVehicle(
      String price,
      String purchaseDate,
      String model,
      String brand,
      String manufactureYear,
      String plate,
      String date,
      ) async {
    try {
      final vehicle = Vehicle(
        price: double.parse(price),
        model: model,
        brand: brand,
        manufactureYear: manufactureYear,
        plate: plate,
        vehicleYear: date,
        purchaseDate: purchaseDate,
      );

      await vehicleDatabase.insert(vehicle);
      loadVehicles();
    } catch (e) {
      throw e;
    }
  }
}
