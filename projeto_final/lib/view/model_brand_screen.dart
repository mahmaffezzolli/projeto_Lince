import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:projeto_final/view/plate_screen.dart';
import 'package:provider/provider.dart';
import '../repositories/vehicle_repositorie.dart';

const Color fundo = Color.fromRGBO(70, 130, 169, 1);

class ModelBrandScreen extends StatelessWidget {
  final TextEditingController brandController = TextEditingController();
  final TextEditingController modelController = TextEditingController();

  ModelBrandScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: fundo,
      ),
      home: Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: GestureDetector(
              onTap: () {
                brandController.clear();
                modelController.clear();
                FocusScope.of(context).unfocus();
              },
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
                            const SizedBox(height: 10),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: const LinearProgressIndicator(
                                value: 0.2,
                                backgroundColor: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 20),
                            BrandDropDown(
                              brandController: brandController,
                            ),
                            const SizedBox(height: 20),
                            ModelDropDown(
                              brandController: brandController,
                              modelController: modelController,
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
                                  icon: const Icon(Icons.arrow_forward,
                                      color: Colors.black),
                                  onPressed: () {
                                    final brand = brandController.text;
                                    final model = modelController.text;

                                    if (brand.isNotEmpty && model.isNotEmpty) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                              const ManufacturePlateScreen()));
                                    } else {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            icon: const Icon(
                                                Icons.error_outline_outlined),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(10),
                                            ),
                                            actionsAlignment:
                                            MainAxisAlignment.center,
                                            title: const Text('Error'),
                                            backgroundColor:
                                            const Color.fromRGBO(
                                                255, 109, 96, 1),
                                            content: const Text(
                                              'Por favor selecione os campos ',
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                            actions: <Widget>[
                                              TextButton(
                                                style: TextButton.styleFrom(
                                                  backgroundColor:
                                                  const Color.fromRGBO(
                                                      255, 234, 221, 1),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        20),
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
          ),
        ),
      ),
    );
  }
}

// Restante do código...

class BrandDropDown extends StatelessWidget {
  final TextEditingController brandController;

  const BrandDropDown({
    Key? key,
    required this.brandController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vehicleProvider = Provider.of<VehicleProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TypeAheadFormField<String>(
          textFieldConfiguration: TextFieldConfiguration(
            controller: brandController,
            decoration: const InputDecoration(
              labelText: 'Vehicle Brand',
              labelStyle: TextStyle(
                color: Colors.black,
              ),
              icon: Icon(Icons.directions_car),
              iconColor: Color.fromARGB(255, 90, 90, 90),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromARGB(255, 90, 90, 90),
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromARGB(255, 90, 90, 90),
                ),
              ),
            ),
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
          suggestionsCallback: (pattern) async {
            return await vehicleProvider.filterCarBrands(pattern);
          },
          itemBuilder: (context, suggestion) {
            return ListTile(
              title: Text(suggestion),
              textColor: Colors.black,
            );
          },
          onSuggestionSelected: (suggestion) {
            brandController.text = suggestion;
          },
          suggestionsBoxDecoration: SuggestionsBoxDecoration(
            color: const Color.fromRGBO(246, 244, 235, 1),
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ],
    );
  }
}

class ModelDropDown extends StatelessWidget {
  final TextEditingController brandController;
  final TextEditingController modelController;

  const ModelDropDown({
    Key? key,
    required this.brandController,
    required this.modelController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vehicleProvider = Provider.of<VehicleProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TypeAheadFormField<String>(
          textFieldConfiguration: TextFieldConfiguration(
            controller: modelController,
            decoration: const InputDecoration(
              labelText: 'Vehicle Model',
              labelStyle: TextStyle(
                color: Colors.black,
              ),
              icon: Icon(Icons.directions_car),
              iconColor: Color.fromARGB(255, 90, 90, 90),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromARGB(255, 90, 90, 90),
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromARGB(255, 90, 90, 90),
                ),
              ),
            ),
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
          suggestionsCallback: (pattern) async {
            final selectedBrandName = brandController.text;
            final selectedBrand =
            vehicleProvider.getSelectedBrand(selectedBrandName);

            final selectedBrandId = selectedBrand['id'];

            return await vehicleProvider.filterCarModels(
                'cars', selectedBrandId, pattern);
          },
          itemBuilder: (context, suggestion) {
            return ListTile(
              title: Text(suggestion),
              textColor: Colors.black,
            );
          },
          onSuggestionSelected: (suggestion) {
            modelController.text = suggestion;
          },
          suggestionsBoxDecoration: SuggestionsBoxDecoration(
            color: const Color.fromRGBO(246, 244, 235, 1),
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ],
    );
  }
}