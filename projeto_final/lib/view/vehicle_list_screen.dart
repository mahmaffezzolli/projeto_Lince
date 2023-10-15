import 'package:flutter/material.dart';
import 'package:projeto_final/entities/vehicle.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:projeto_final/storages/vehicle_database.dart';
import 'package:projeto_final/vehicle_list_provider.dart';
import 'package:provider/provider.dart';

class VehicleListScreen extends StatelessWidget {
  const VehicleListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: <Widget>[
          Container(
            width: 380,
            padding: const EdgeInsets.only(top: 40.0),
            child: TypeAheadFormField<Vehicle>(
              textFieldConfiguration: const TextFieldConfiguration(
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hintText: 'Pesquisar veiculo...',
                  prefixIcon: Icon(
                    Icons.search,
                    color: Color.fromRGBO(52, 66, 86, 1.0),
                  ),
                  fillColor: Color.fromRGBO(116, 155, 194, 1),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                ),
              ),
              suggestionsCallback: (pattern) async {
                final List<Vehicle> vehicles =
                    await Provider.of<VehicleController>(context, listen: false)
                        .getAllVehicles();
                return vehicles.where((vehicle) =>
                    vehicle.brand
                        ?.toLowerCase()
                        .contains(pattern.toLowerCase()) ==
                    true);
              },
              itemBuilder: (context, suggestion) {
                return ListTile(
                  title: Text(suggestion.model ?? ''),
                  subtitle: Text(suggestion.brand ?? ''),
                );
              },
              onSuggestionSelected: (suggestion) {
                // Aqui você pode adicionar a ação quando um veículo for selecionado.
              },
            ),
          ),
          Consumer<VehicleListProvider>(
            builder: (context, controller, child) {
              if (controller.vehicles.isEmpty) {
                return const CircularProgressIndicator();
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.vehicles.length,
                  itemBuilder: (context, index) {
                    Vehicle vehicle = controller.vehicles[index];

                    return Column(
                      children: [
                        if (index != 0)
                          const Divider(
                            color: Color.fromRGBO(107, 148, 180, 1.0),
                            height: 3,
                            thickness: 1,
                            indent: 10,
                            endIndent: 10,
                          ),
                        ListTile(
                          leading: const Icon(
                            Icons.store,
                            color: Color.fromRGBO(116, 155, 194, 1),
                            size: 30,
                          ),
                          title: Text(vehicle.model!),
                          subtitle: Text(vehicle.brand!),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                  color: Color.fromRGBO(116, 155, 194, 1),
                                ),
                                onPressed: () async {
                                  // Adicione a lógica de edição aqui.
                                },
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Confirmar Exclusão'),
                                        content: const Text(
                                            'Tem certeza de que deseja excluir esta loja?'),
                                        actions: <Widget>[
                                          TextButton(
                                            child: const Text('Cancelar'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          TextButton(
                                            child: const Text('Excluir'),
                                            onPressed: () async {
                                              controller.deleteVehicle(vehicle);
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                          onTap: () {
                            // Adicione a ação quando um veículo for selecionado.
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
    );
  }
}
