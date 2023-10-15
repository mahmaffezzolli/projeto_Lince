import 'package:flutter/material.dart';
import 'package:projeto_final/store_list_provider.dart';
import 'package:provider/provider.dart';

import '../entities/store.dart';

class StoreDetailsScreen extends StatelessWidget {
  final Store store;

  const StoreDetailsScreen({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 200,
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(145, 200, 228, 1),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(120.0),
                      bottomRight: Radius.circular(120.0),
                    ),
                  ),
                ),
                const Positioned(
                  top: 50,
                  left: 160,
                  child: Center(
                    child: Icon(
                      Icons.car_rental,
                      size: 100.0,
                      color: Colors.white,
                    ),
                  ),
                ),
                AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  leading: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 350,
                    child: TextFormField(
                      initialValue: store.name,
                      decoration:const InputDecoration(
                        labelText: 'Store Name',
                        fillColor: Colors.lightBlueAccent,
                        labelStyle: TextStyle(
                          color: Color.fromRGBO(116, 155, 194, 1),
                        ),
                      ),
                      onChanged: (value) {
                        store.name = value;
                      },
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Container(
                    width: 350,
                    child: TextFormField(
                      initialValue: store.cnpj,
                      decoration: InputDecoration(
                        labelText: 'CNPJ',
                        fillColor: Colors.lightBlueAccent,
                        labelStyle: TextStyle(
                          color: Color.fromRGBO(116, 155, 194, 1),
                        ),
                      ),
                      onChanged: (value) {
                        store.cnpj = value;
                      },
                    ),
                  ),
                  SizedBox(height: 50.0),
                  Center(
                    child: ElevatedButton(

                      onPressed: () {
                        Provider.of<StoreListProvider>(context, listen: false)
                            .updateStore(store);

                        Navigator.of(context).pop();
                      },
                      style: ButtonStyle(
                        backgroundColor:MaterialStateProperty.all<Color>(
                            Color.fromRGBO(145, 200, 228, 1),
                        ),
                          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                            EdgeInsets.symmetric(vertical: 12.0, horizontal: 29.0),
                        ),
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      child: Text('Save'),
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
