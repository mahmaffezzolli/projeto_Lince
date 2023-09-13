import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../repositories/vehicle_repositorie.dart';

class ModelBrandScreen extends StatelessWidget {
  const ModelBrandScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController modelController = TextEditingController();
    final TextEditingController brandController = TextEditingController();

    return Scaffold(
      appBar: null,
      body: Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: () {
                brandController.clear();
                modelController.clear();
                FocusScope.of(context).unfocus();
              },
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
                      BrandDropDown(
                        brandController: brandController,
                      ),
                      const SizedBox(height: 20),
                      ModelDropDown(
                        brandController: brandController,
                        modelController: modelController,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          final brand = brandController.text;
                          final model = modelController.text;

                          if (brand.isNotEmpty && model.isNotEmpty) {
                            // Navegue para a próxima tela ou realize a ação desejada
                            Navigator.pushNamed(context, '/manufacture_plate');
                          } else {
                            // Informe ao usuário que ambos os campos devem ser preenchidos
                            final snackBar = SnackBar(
                              content: Text(
                                  'Please select both vehicle brand and model.'),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        },
                        child: const Text('Next'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

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
        TextFormField(
          controller: brandController,
          decoration: const InputDecoration(
            labelText: 'Vehicle Brand',
          ),
        ),
        Consumer<VehicleProvider>(
          builder: (context, vehicleProvider, _) {
            final brandSuggestions = vehicleProvider.brandSuggestions;

            return GestureDetector(
              onTap: () async {
                final value = brandController.text;
                final suggestions =
                    await vehicleProvider.filterCarBrands(value);
                vehicleProvider.setBrandSuggestions(suggestions);
              },
              child: Column(
                children: [
                  if (brandSuggestions.isNotEmpty)
                    Container(
                      height: 200,
                      child: ListView.builder(
                        itemCount: brandSuggestions.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(brandSuggestions[index]),
                            onTap: () {
                              brandController.text = brandSuggestions[index];
                              brandController.selection =
                                  TextSelection.fromPosition(TextPosition(
                                offset: brandController.text.length,
                              ));
                              vehicleProvider
                                  .getSelectedBrand(brandSuggestions[index]);
                            },
                          );
                        },
                      ),
                    ),
                ],
              ),
            );
          },
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

    final selectedBrand =
        vehicleProvider.getSelectedBrand(brandController.text);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          controller: modelController,
          decoration: const InputDecoration(
            labelText: 'Vehicle Model',
          ),
          enabled: selectedBrand !=
              null, // Habilitar o campo apenas se a marca estiver selecionada
        ),
        Consumer<VehicleProvider>(
          builder: (context, vehicleProvider, _) {
            final modelSuggestions = vehicleProvider.modelSuggestions;

            return GestureDetector(
              onTap: () async {
                if (selectedBrand != null) {
                  final value = modelController.text;
                  final suggestions = await vehicleProvider.filterCarModels(
                      'cars', selectedBrand['id'], value);
                  vehicleProvider.setModelSuggestions(suggestions);
                }
              },
              child: Column(
                children: [
                  if (modelSuggestions.isNotEmpty && selectedBrand != null)
                    SizedBox(
                      height: 200,
                      child: ListView.builder(
                        itemCount: modelSuggestions.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(modelSuggestions[index]),
                            onTap: () {
                              modelController.text = modelSuggestions[index];
                              modelController.selection =
                                  TextSelection.fromPosition(TextPosition(
                                offset: modelController.text.length,
                              ));
                            },
                          );
                        },
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
