import 'dart:convert';
import 'package:flutter/material.dart';
import '../entities/vehicle.dart';
import 'package:http/http.dart' as http;

class VehicleProvider with ChangeNotifier {
  Vehicle _vehicle = Vehicle();
  List<String> brandSuggestions = [];
  List<String> modelSuggestions = [];

  Vehicle get veiculo => _vehicle;

  void setBrand(String brand) {
    _vehicle.brand = brand;
    notifyListeners();
  }

  void setModel(String model) {
    _vehicle.model = model;
    notifyListeners();
  }

  void setManufactureYear(String manufactureYear) {
    _vehicle.manufactureYear = manufactureYear;
    notifyListeners();
  }

  void setPlate(String plate) {
    _vehicle.plate = plate;
    notifyListeners();
  }

  void setVehicleYear(String vehicleYear) {
    _vehicle.vehicleYear = vehicleYear;
    notifyListeners();
  }

  void setPrice(String price) {
    _vehicle.price = double.tryParse(price) ?? 0.0;
    notifyListeners();
  }

  void reset() {
    _vehicle = Vehicle();
    notifyListeners();
  }

  List<Map<String, dynamic>> carBrands = [];
  Map<String, dynamic> getSelectedBrand(String brandName) {
    final selectedBrand = carBrands.firstWhere(
      (brand) => brand['name'] == brandName,
      orElse: () => <String, dynamic>{},
    );
    return selectedBrand;
  }

  Future<List<String>> filterCarBrands(String value) async {
    final response = await http.get(
      Uri.parse('https://parallelum.com.br/fipe/api/v1/carros/marcas'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> brandsJson = json.decode(response.body);
      carBrands = brandsJson
          .where((brand) => brand['nome']
              .toString()
              .toLowerCase()
              .contains(value.toLowerCase()))
          .map((brand) {
        return {
          'id': brand['codigo'],
          'name': brand['nome'],
        };
      }).toList();

      final List<String> brands =
          carBrands.map((brand) => brand['name'] as String).toList();

      return brands;
    } else {
      throw Exception('Failed to fetch car brands');
    }
  }

  Future<List<String>> filterCarModels(
      String vehicleType, int brandId, String value) async {
    final response = await http.get(
      Uri.parse(
          'https://parallelum.com.br/fipe/api/v2/$vehicleType/brands/$brandId/models'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> modelsJson = json.decode(response.body);
      final List<String> models = modelsJson
          .where((model) => model['name']
              .toString()
              .toLowerCase()
              .contains(value.toLowerCase()))
          .map((model) => model['name'] as String)
          .toList();

      return models;
    } else {
      throw Exception('Failed to fetch car models');
    }
  }

  void setBrandSuggestions(List<String> suggestions) {
    brandSuggestions = suggestions;
    notifyListeners();
  }

  void setModelSuggestions(List<String> suggestions) {
    modelSuggestions = suggestions;
    notifyListeners();
  }
}
