import 'package:flutter/material.dart';
import 'package:projeto_final/entities/store.dart';
import 'package:projeto_final/storages/user_database.dart';
import 'package:projeto_final/store_list_provider.dart';
import 'package:projeto_final/view/store_details_screen.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';

class StoreList extends StatelessWidget {
  const StoreList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: 380,
          padding: const EdgeInsets.only(top: 40.0),
          child: TypeAheadFormField<Store>(
            textFieldConfiguration: const TextFieldConfiguration(
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: 'Pesquisar loja...',
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
              final List<Store> stores =
                  await Provider.of<StoreController>(context, listen: false)
                      .getAllStores();
              return stores.where((store) =>
                  store.name.toLowerCase().contains(pattern.toLowerCase()));
            },
            itemBuilder: (context, suggestion) {
              return ListTile(
                title: Text(suggestion.name),
                subtitle: Text(suggestion.cnpj),
              );
            },
            onSuggestionSelected: (suggestion) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StoreDetailsScreen(store: suggestion),
                ),
              );
            },
          ),
        ),
        Expanded(child: Consumer<StoreListProvider>(
          builder: (context, controller, child) {
            return FutureBuilder<List<Store>>(
              key: UniqueKey(),
              future: controller.loadStores(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return const Text('Error loading stores');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Text('No stores found');
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      Store store = snapshot.data![index];

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
                            title: Text(store.name),
                            subtitle: Text(store.cnpj),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                IconButton(
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Color.fromRGBO(116, 155, 194, 1),
                                  ),
                                  onPressed: () async {
                                    final updatedStore = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            StoreDetailsScreen(store: store),
                                      ),
                                    );
                                    if (updatedStore != null) {
                                      controller.updateStore(store);
                                    }
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
                                          title:
                                              const Text('Confirmar Exclusão'),
                                          content: const Text(
                                              'Tem certeza de que deseja excluir '
                                                  'esta loja?'),
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
                                                controller.deleteStore(store);

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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      StoreDetailsScreen(store: store),
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
              },
            );
          },
        )),
      ],
    );
  }
}
